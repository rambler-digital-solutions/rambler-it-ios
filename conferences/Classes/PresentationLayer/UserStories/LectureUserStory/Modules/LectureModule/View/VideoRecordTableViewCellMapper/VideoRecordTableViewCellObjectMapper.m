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
#import "LectureMaterialViewModel.h"
#import "YouTubeIdentifierDeriviator.h"

@implementation VideoRecordTableViewCellObjectMapper

- (VideoRecordTableViewCellObject *)videoRecordCellObjectWithVideoMaterial:(LectureMaterialViewModel *)videoMaterial {
    NSURL *videoUrl = [NSURL URLWithString:videoMaterial.link];
    NSURL *previewImageUrl = [self.thumbnailGenerator generateThumbnailWithVideoURL:videoUrl];
    id cellObject = [VideoRecordTableViewCellObject objectWithPreviewImageUrl:previewImageUrl
                                                                videoMaterial:videoMaterial];
    return cellObject;
}

@end
