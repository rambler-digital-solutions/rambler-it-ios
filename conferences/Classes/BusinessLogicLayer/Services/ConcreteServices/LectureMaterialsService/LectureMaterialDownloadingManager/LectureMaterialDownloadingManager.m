//
//  LectureMaterialDownloadingManager.m
//  Conferences
//
//  Created by Konstantin Zinovyev on 03.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureMaterialDownloadingManager.h"
#import "LectureMaterialModelObject.h"
#import "VideoMaterialHandlerConstants.h"
#import <MagicalRecord/MagicalRecord.h>
#import <objc/runtime.h>

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
    [self.delegatesByIdentifier setObject:weakDelegate forKey:url];
}

- (void)updateDelegate:(id)delegate forURL:(NSString *)url {
    __weak id weakDelegate = delegate;
    id storedDelegate = [self.delegatesByIdentifier objectForKey:url];
    if (storedDelegate) {
        [self.delegatesByIdentifier setObject:weakDelegate forKey:url];
    }
}

// TODO: записывать в нормальный путь
// TODO: сохранять в базу (проблема с completionBlock)
// TODO: удалять по всем завершающим операциям

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSString *materialLink = session.sessionDescription;
    NSString *destinationPath = [self filePathLocalVideo];
    [self moveLectureMaterialFileFromPath:location.absoluteString
                                   toPath:destinationPath];
    [self updateLectureMaterialWithLink:materialLink
                               filePath:location.absoluteString];
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    [self.delegatesByIdentifier removeObjectForKey:materialLink];
    [delegate URLSession:session downloadTask:downloadTask
                    didFinishDownloadingToURL:location];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    [self.delegatesByIdentifier removeObjectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]) {
        [delegate URLSession:session task:task didCompleteWithError:error];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)]) {
        [delegate URLSession:session downloadTask:downloadTask didWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
    }
}

#pragma mark - NSObject

- (BOOL)respondsToSelector:(SEL)selector {
    return [self isSelector:selector conformToProtocol:@protocol(NSURLSessionDownloadDelegate)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [LectureMaterialDownloadingManager instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = [invocation selector];
    id argument = nil;
    [invocation getArgument:&argument atIndex:2];
    if (![argument isKindOfClass:[NSURLSession class]]) {
        return;
    }
    NSURLSession *session = argument;
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:selector]) {
        [invocation invokeWithTarget:delegate];
    }
}

#pragma mark - Private methods 

- (void)moveLectureMaterialFileFromPath:(NSString *)sourcePath toPath:(NSString *)destinationPath {
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isMove = [fileManager moveItemAtPath:sourcePath
                                       toPath:destinationPath
                                        error:&error];
    if (!isMove) {
        [fileManager removeItemAtPath:sourcePath
                                error:&error];
    }
}

- (void)updateLectureMaterialWithLink:(NSString *)link filePath:(NSString *)filePath {
    NSManagedObjectContext *rootContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootContext performBlockAndWait:^{
        NSString *attributeName = LectureMaterialModelObjectAttributes.link;
        NSArray *materials = [LectureMaterialModelObject MR_findByAttribute:attributeName withValue:link];
        for (LectureMaterialModelObject *material in materials) {
            material.localURL = filePath;
        }
        [rootContext MR_saveToPersistentStoreAndWait];
    }];
}

- (BOOL)isSelector:(SEL)selector conformToProtocol:(Protocol *)protocol {
    struct objc_method_description methodRequired = protocol_getMethodDescription(protocol, selector, YES, YES);
    struct objc_method_description methodNonRequired = protocol_getMethodDescription(protocol, selector, NO, YES);
    
    if (methodRequired.name || methodNonRequired.name) {
        return YES;
    }
    return NO;
}

- (NSString *)filePathLocalVideo {
    NSString  *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString  *filePath = [NSString stringWithFormat:@"%@%@", documentsDirectory,RITRelativePath];
    return filePath;
}

@end
