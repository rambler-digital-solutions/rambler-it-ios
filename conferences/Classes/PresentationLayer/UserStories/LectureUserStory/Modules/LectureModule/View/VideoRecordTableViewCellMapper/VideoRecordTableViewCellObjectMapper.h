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

/**
 @author Konstantin Zinovyev
 
 Mapping from video material to video cell object

 @param videoMaterial view model
 @return video cell object
 */
- (VideoRecordTableViewCellObject *)videoRecordCellObjectWithVideoMaterial:(LectureMaterialViewModel *)videoMaterial;

@end
