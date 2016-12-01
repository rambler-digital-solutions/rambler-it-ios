//
//  VideoMaterialDownloadingStatesStorage.h
//  Conferences
//
//  Created by k.zinovyev on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoMaterialDownloadingStatesStorage : NSObject

- (BOOL)isVideoDownloadingWithIdentifier:(NSString *)identifier;

- (void)addVideoIdentifier:(NSString *)identifier;

- (void)removeVideoIdentifier:(NSString *)identifier;

@end
