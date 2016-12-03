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
#import "VideoMaterialHandlerConstants.h"
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
                            completion:(LectureMaterialCompletionBlock)completionBlock {
    NSURL *videoUrl = [NSURL URLWithString:lectureMaterial.link];
    BOOL isVideoFromYoutube = [self.deriviator checkIfVideoIsFromYouTube:videoUrl];
    if (!isVideoFromYoutube) {
        return;
    }
    NSString *identifier = [self.deriviator deriveIdentifierFromUrl:videoUrl];
    if ([self.statesStorage isVideoDownloadingWithIdentifier:identifier]) {
        return;
    }
    [self.statesStorage addVideoIdentifier:identifier];
    
    NSString *filePath = [self filePathLocalVideoForVideoIdentifier:identifier];
    @weakify(self);
    [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:identifier
                                           completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
           @strongify(self);
           if (error) {
               [self.statesStorage removeVideoIdentifier:identifier];
               completionBlock(nil, error);
               return;
           }
           NSURL *streamURL = [self getStreamURLForVideo:video];
           if (!streamURL) {
               NSError *noStreamError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain
                                                            code:XCDYouTubeErrorNoStreamAvailable
                                                        userInfo:nil];
               [self.statesStorage removeVideoIdentifier:identifier];
               completionBlock(nil, noStreamError);
               return;
           }
                                               
                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       NSData *urlData = [NSData dataWithContentsOfURL:streamURL];
                       if ( urlData ) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [urlData writeToFile:filePath
                                         atomically:YES];
                               [self.statesStorage removeVideoIdentifier:identifier];
                               completionBlock(filePath, error);
                           });
                       }
                   });
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

- (NSString *)filePathLocalVideoForVideoIdentifier:(NSString *)identifier {
    NSString  *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = [NSString stringWithFormat:@"%@%@", identifier,RITFormatVideo];
    NSString  *filePath = [NSString stringWithFormat:@"%@%@", documentsDirectory,RITRelativePath];
    NSString  *fileFullPath = [NSString stringWithFormat:@"%@/%@", filePath,fileName];
    return fileFullPath;
}

@end
