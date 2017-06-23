 // Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LectureMaterialDownloadingManager.h"
#import "LectureMaterialModelObject.h"
#import "LectureMaterialConstants.h"
#import <MagicalRecord/MagicalRecord.h>
#import <objc/runtime.h>
#import "LectureMaterialDownloadingDelegate.h"

@interface LectureMaterialDownloadingManager ()

@property (nonatomic, strong) NSMapTable<NSString *, id <NSURLSessionDownloadDelegate>> *delegatesByIdentifier;

@end

@implementation LectureMaterialDownloadingManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _delegatesByIdentifier = [[NSMapTable alloc] init];
    }
    return self;
}

- (void)registerDelegate:(id)delegate forURL:(NSString *)url {
    __weak id weakDelegate = delegate;
    [weakDelegate didStartDownloadingLectureMaterialWithLink:url];
    @synchronized (self) {
        [self.delegatesByIdentifier setObject:weakDelegate
                                       forKey:url];
    }
}

- (void)updateDelegate:(id)delegate forURL:(NSString *)url {
    __weak id weakDelegate = delegate;
    id storedDelegate = [self.delegatesByIdentifier objectForKey:url];
    if (storedDelegate) {
        [weakDelegate didStartDownloadingLectureMaterialWithLink:url];
        @synchronized (self) {
            [self.delegatesByIdentifier setObject:weakDelegate
                                           forKey:url];
        }
    }
}

#pragma mark - Require methods NSURLSessionDownloadDelegate 

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)source {
    
    NSString *materialLink = session.sessionDescription;
    NSURL *destination = [self cachedFileURLLocalVideoFromPath:source.path];
    BOOL isMove = [self moveLectureMaterialFileFromURL:source
                                                 toURL:destination];
    destination = isMove ? destination : source;
    [self updateLectureMaterialWithLink:materialLink
                               filePath:destination.path];
    id delegate = [self.delegatesByIdentifier objectForKey:materialLink];
    [self.delegatesByIdentifier removeObjectForKey:materialLink];
    [delegate URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:destination];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    [self.delegatesByIdentifier removeObjectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]) {
        [delegate URLSession:session task:task didCompleteWithError:error];
    }
}

#pragma mark - Other methods

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)]) {
        [delegate URLSession:session downloadTask:downloadTask didWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:)]) {
        [delegate URLSession:session downloadTask:downloadTask didResumeAtOffset:fileOffset expectedTotalBytes:expectedTotalBytes];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:)]) {
        [delegate URLSession:session task:task willPerformHTTPRedirection:response newRequest:request completionHandler:completionHandler];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:didReceiveChallenge:completionHandler:)]) {
        [delegate URLSession:session didReceiveChallenge:challenge completionHandler:completionHandler];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:task:needNewBodyStream:)]) {
        [delegate URLSession:session task:task needNewBodyStream:completionHandler];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(connection:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite:)]) {
        [delegate URLSession:session task:task didSendBodyData:bytesSent totalBytesSent:totalBytesSent totalBytesExpectedToSend:totalBytesExpectedToSend];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:task:didFinishCollectingMetrics:)]) {
        [delegate URLSession:session task:task didFinishCollectingMetrics:metrics];
    }
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:didBecomeInvalidWithError:)]) {
        [delegate URLSession:session didBecomeInvalidWithError:error];
    }
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:didReceiveChallenge:completionHandler:)]) {
        [delegate URLSession:session didReceiveChallenge:challenge completionHandler:completionHandler];
    }
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSessionDidFinishEventsForBackgroundURLSession:)]) {
        [delegate URLSessionDidFinishEventsForBackgroundURLSession:session];
    }
}

#pragma mark - Private methods

- (BOOL)moveLectureMaterialFileFromURL:(NSURL *)source
                                 toURL:(NSURL *)destination {
    NSError *error;
    return [self.fileManager moveItemAtURL:source
                                toURL:destination
                                error:&error];
    
}

- (void)updateLectureMaterialWithLink:(NSString *)link
                             filePath:(NSString *)filePath {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        NSString *attributeName = LectureMaterialModelObjectAttributes.link;
        NSArray *materials = [LectureMaterialModelObject MR_findByAttribute:attributeName
                                                                  withValue:link
                                                                  inContext:localContext];
        for (LectureMaterialModelObject *material in materials) {
            material.localURL = filePath;
        }
    }];
}

- (NSURL *)cachedFileURLLocalVideoFromPath:(NSString *)oldPath {
    NSString  *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = [[oldPath lastPathComponent] stringByDeletingPathExtension];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:RITRelativePath];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:fileName];
    // TODO: Завязка на формат видео, хорошо бы от это избавиться
    documentsDirectory = [documentsDirectory stringByAppendingPathExtension:RITFormatVideo];
    return [NSURL fileURLWithPath:documentsDirectory];
}

@end
