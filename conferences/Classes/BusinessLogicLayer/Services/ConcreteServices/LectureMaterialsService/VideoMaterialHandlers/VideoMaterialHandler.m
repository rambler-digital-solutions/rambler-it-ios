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

#import "VideoMaterialHandler.h"
#import <XCDYouTubeClient.h>

#import <MagicalRecord/MagicalRecord.h>
#import "EXTScope.h"
#import "LectureMaterialType.h"
#import "LectureMaterialModelObject.h"

#import "YouTubeIdentifierDeriviator.h"

@implementation VideoMaterialHandler

- (BOOL)canHandleLectureMaterial:(LectureMaterialModelObject *)lectureMaterial {;
    BOOL isVideoMaterialType = [lectureMaterial.type integerValue] == LectureMaterialVideoType;
    return isVideoMaterialType;
}

- (void)downloadToCacheLectureMaterial:(LectureMaterialModelObject *)lectureMaterial
                              delegate:(id<NSURLSessionDownloadDelegate>)delegate
                            completion:(LectureMaterialCompletionBlock)completionBlock {
    NSURL *videoUrl = [NSURL URLWithString:lectureMaterial.link];
    BOOL isVideoFromYoutube = [self.deriviator checkIfVideoIsFromYouTube:videoUrl];
    if (!isVideoFromYoutube) {
        return;
    }
    NSString *identifier = [self.deriviator deriveIdentifierFromUrl:videoUrl];
    @weakify(self);
    [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:identifier
                                           completionHandler:^(XCDYouTubeVideo *video, NSError *error)
    {
            @strongify(self);
            if (error) {
                completionBlock(nil, error);
                return;
            }
            NSURL *streamURL = [self getStreamURLForVideo:video];
            if (!streamURL) {
                NSError *noStreamError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain
                                                             code:XCDYouTubeErrorNoStreamAvailable
                                                         userInfo:nil];
                completionBlock(nil, noStreamError);
                return;
            }
                                        
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                                  delegate:delegate
                                                             delegateQueue:nil];
            session.sessionDescription = lectureMaterial.link;
            NSURLSessionDownloadTask *task = [session downloadTaskWithURL:streamURL];
        
            [task resume];
    }];
}

- (void)removeFromCacheLectureMaterial:(LectureMaterialModelObject *)lectureMaterial
                            completion:(LectureMaterialCompletionBlock)completionBlock {
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:lectureMaterial.localURL
                                               error:&error];
    completionBlock(nil,error);
}

#pragma mark - Private Methods

- (NSURL *)getStreamURLForVideo:(XCDYouTubeVideo *)video {
    NSURL *streamURL = nil;
    for (NSNumber *videoQuality in self.videoQualities) {
        streamURL = video.streamURLs[videoQuality];
        if (streamURL) {
            return streamURL;
        }
    }
    return nil;
}

- (NSArray *) videoQualities
{
    return @[@(XCDYouTubeVideoQualityHD720),
             @(XCDYouTubeVideoQualityMedium360),
             @(XCDYouTubeVideoQualitySmall240) ];
}

@end
