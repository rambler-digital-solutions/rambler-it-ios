//
//  VideoRecordTableViewCellObjectMapper.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 27.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoRecordTableViewCellObject;
@class LectureMaterialPlainObject;
@class VideoThumbnailGenerator;
@class VideoMaterialDownloadingStatesStorage;
@class YouTubeIdentifierDeriviator;

@interface VideoRecordTableViewCellObjectMapper : NSObject

@property (nonatomic, strong) VideoThumbnailGenerator *thumbnailGenerator;
@property (nonatomic, strong) YouTubeIdentifierDeriviator *deriviator;
@property (nonatomic, strong) VideoMaterialDownloadingStatesStorage *statesStorage;

- (VideoRecordTableViewCellObject *)videoRecordCellObjectWithVideoMaterial:(LectureMaterialPlainObject *)videoMaterial;

@end
