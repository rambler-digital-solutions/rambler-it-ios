//
//  VideoRecordTableViewCellObjectMapper.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 27.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoRecordTableViewCellObject;
@class LectureMaterialViewModel;
@class VideoThumbnailGenerator;
@class YouTubeIdentifierDeriviator;

@interface VideoRecordTableViewCellObjectMapper : NSObject

@property (nonatomic, strong) VideoThumbnailGenerator *thumbnailGenerator;
@property (nonatomic, strong) YouTubeIdentifierDeriviator *deriviator;

- (VideoRecordTableViewCellObject *)videoRecordCellObjectWithVideoMaterial:(LectureMaterialViewModel *)videoMaterial;

@end
