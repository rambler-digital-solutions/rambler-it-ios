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

@interface VideoRecordTableViewCellObjectMapper : NSObject

@property (nonatomic, strong) VideoThumbnailGenerator *thumbnailGenerator;

- (VideoRecordTableViewCellObject *)videoRecordCellObjectWithVideoMaterial:(LectureMaterialPlainObject *)videoMaterial;

@end
