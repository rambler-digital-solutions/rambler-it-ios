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

@implementation VideoRecordTableViewCellObjectMapper

- (VideoRecordTableViewCellObject *)videoRecordCellObjectWithVideoMaterial:(LectureMaterialPlainObject *)videoMaterial {
    NSURL *videoUrl = [NSURL URLWithString:videoMaterial.link];
    NSURL *previewImageUrl = [self.thumbnailGenerator generateThumbnailWithVideoURL:videoUrl];
    BOOL isVideoCached = [self checkVideoExistsByPath:videoMaterial.localURL];
    VideoRecordTableViewCellObject *videoRecordTableViewCellObject = [VideoRecordTableViewCellObject objectWithPreviewImageUrl:previewImageUrl
                                                                                                                 isVideoCached:isVideoCached
                                                                                                                 videoMaterial:videoMaterial];
    return videoRecordTableViewCellObject;
}

#pragma mark - Private methods

- (BOOL)checkVideoExistsByPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];;
}
@end
