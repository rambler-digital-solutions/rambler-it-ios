//
//  VideoMaterialDownloadingStatesStorage.h
//  Conferences
//
//  Created by k.zinovyev on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LectureInteractorInput.h"

@interface VideoMaterialDownloadingStatesStorage : NSObject

@property (nonatomic, weak) id<LectureInteractorInput> delegate;

- (BOOL)isVideoDownloadingWithIdentifier:(NSString *)identifier;

- (void)addVideoIdentifier:(NSString *)identifier;

- (void)removeVideoIdentifier:(NSString *)identifier;

@end
