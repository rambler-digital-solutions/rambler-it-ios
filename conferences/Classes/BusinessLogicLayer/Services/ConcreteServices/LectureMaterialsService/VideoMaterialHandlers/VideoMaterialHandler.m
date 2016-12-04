//
//  VideoMaterialHandlers.m
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "VideoMaterialHandler.h"
#import <XCDYouTubeClient.h>

#import <MagicalRecord/MagicalRecord.h>
#import "EXTScope.h"
#import "LectureMaterialType.h"
#import "LectureMaterialPlainObject.h"
#import "LectureMaterialModelObject.h"

#import "YouTubeIdentifierDeriviator.h"
#import "VideoMaterialDownloadingStatesStorage.h"

@implementation VideoMaterialHandler

- (BOOL)canHandleLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial {;
    BOOL isVideoMaterialType = [lectureMaterial.type integerValue] == LectureMaterialVideoType;
    return isVideoMaterialType;
}

- (id)obtainFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial {
    LectureMaterialModelObject *modelObject = [LectureMaterialModelObject MR_findFirstByAttribute:LectureMaterialModelObjectAttributes.lectureMaterialId
                                                                                        withValue:lectureMaterial.lectureMaterialId];
    return modelObject;
}

- (void)downloadToCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
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

- (void)removeFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
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
