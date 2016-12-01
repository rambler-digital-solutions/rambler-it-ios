//
//  VideoRecordTableViewCellObjectMapper.m
//  Conferences
//
//  Created by Konstantin Zinovyev on 27.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "VideoRecordTableViewCellObjectMapper.h"
#import "VideoRecordTableViewCellObject.h"
#import "VideoThumbnailGenerator.h"
#import "LectureMaterialPlainObject.h"
#import "VideoMaterialDownloadingStatesStorage.h"
#import "YouTubeIdentifierDeriviator.h"

@implementation VideoRecordTableViewCellObjectMapper

- (VideoRecordTableViewCellObject *)videoRecordCellObjectWithVideoMaterial:(LectureMaterialPlainObject *)videoMaterial {
    NSURL *videoUrl = [NSURL URLWithString:videoMaterial.link];
    NSURL *previewImageUrl = [self.thumbnailGenerator generateThumbnailWithVideoURL:videoUrl];
    NSString *identifier = [self.deriviator deriveIdentifierFromUrl:videoUrl];
    BOOL isVideoDownloading = [self.statesStorage isVideoDownloadingWithIdentifier:identifier];
    BOOL isVideoCached = [self checkVideoExistsByPath:videoMaterial.localURL];
    id cellObject = [VideoRecordTableViewCellObject objectWithPreviewImageUrl:previewImageUrl
                                                                isVideoCached:isVideoCached
                                                           isVideoDownloading:isVideoDownloading
                                                                videoMaterial:videoMaterial];
    return cellObject;
}

#pragma mark - Private methods

- (BOOL)checkVideoExistsByPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];;
}
@end
