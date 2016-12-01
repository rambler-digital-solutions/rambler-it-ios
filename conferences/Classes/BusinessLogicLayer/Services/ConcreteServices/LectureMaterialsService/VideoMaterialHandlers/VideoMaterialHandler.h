//
//  VideoMaterialHandlers.h
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LectureMaterialsHandler.h"

@class YouTubeIdentifierDeriviator;
@class VideoMaterialDownloadingStatesStorage;

@interface VideoMaterialHandler : NSObject <LectureMaterialsHandler>

@property (nonatomic, strong) YouTubeIdentifierDeriviator *deriviator;
@property (nonatomic, strong) VideoMaterialDownloadingStatesStorage *statesStorage;

@end
