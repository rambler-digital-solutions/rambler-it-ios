//
//  VideoMaterialDownloadingStatesStorage.m
//  Conferences
//
//  Created by k.zinovyev on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "VideoMaterialDownloadingStatesStorage.h"

@interface VideoMaterialDownloadingStatesStorage ()

@property (nonatomic, strong) NSMutableSet *statesStorage;

@end

@implementation VideoMaterialDownloadingStatesStorage

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _statesStorage = [NSMutableSet new];
    }
    
    return self;
}

- (BOOL)isVideoDownloadingWithIdentifier:(NSString *)identifier {
    return [self.statesStorage containsObject:identifier];
}

- (void)addVideoIdentifier:(NSString *)identifier {
    [self.statesStorage addObject:identifier];
}

- (void)removeVideoIdentifier:(NSString *)identifier {
    [self.statesStorage removeObject:identifier];
}

@end
