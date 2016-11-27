//
//  VideoMaterialHandlers.m
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "VideoMaterialHandler.h"
#import "LectureMaterialPlainObject.h"
#import "LectureMaterialType.h"
#import <XCDYouTubeClient.h>
#import "YouTubeIdentifierDeriviator.h"
#import "XCDYouTubeVideo.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LectureMaterialModelObject.h"

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
                            completion:(LectureMaterialDownloadCompletionBlock)completionBlock;{
    NSURL *videoUrl = [NSURL URLWithString:lectureMaterial.link];
    BOOL isVideoFromYoutube = [self.deriviator checkIfVideoIsFromYouTube:videoUrl];
    if (!isVideoFromYoutube) {
        return;
    }
    NSString *identifier = [self.deriviator deriveIdentifierFromUrl:videoUrl];
    
    [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:identifier
                                           completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
            
           if (error) {
               completionBlock(nil, error);
               return;
           }
           NSURL *streamURL = nil;
           
           for (NSNumber *videoQuality in self.videoQualities) {
               streamURL = video.streamURLs[videoQuality];
               if (streamURL) {
                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       NSLog(@"Downloading Started");
                       NSData *urlData = [NSData dataWithContentsOfURL:streamURL];
                       if ( urlData ) {
                           NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                           NSString  *documentsDirectory = [paths objectAtIndex:0];
                           NSString  *filePath = [NSString stringWithFormat:@"%@/%@.mp4", documentsDirectory,identifier];
                           //saving is done on main thread
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [urlData writeToFile:filePath atomically:YES];
                               completionBlock(filePath, error);
                           });
                       }
                       
                   });
                   break;
               }
           }
           
           if (!streamURL) {
               NSError *noStreamError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain
                                                                code:XCDYouTubeErrorNoStreamAvailable
                                                            userInfo:nil];
               completionBlock(nil, noStreamError);
               return;
           }
       }];
}

- (void)removeFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
                                 error:(NSError **)error{
    [[NSFileManager defaultManager] removeItemAtPath:lectureMaterial.localURL
                                               error:error];
    if (!error) {
        NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
        LectureMaterialModelObject *modelObject = [LectureMaterialModelObject MR_findFirstByAttribute:LectureMaterialModelObjectAttributes.lectureMaterialId
                                                                                            withValue:lectureMaterial.lectureMaterialId inContext:rootSavingContext];
        modelObject.localURL = nil;
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }
}

#pragma mark - Private Methods

- (NSArray *) videoQualities
{
    return @[@(XCDYouTubeVideoQualityHD720),
             @(XCDYouTubeVideoQualityMedium360),
             @(XCDYouTubeVideoQualitySmall240) ];
}


@end
