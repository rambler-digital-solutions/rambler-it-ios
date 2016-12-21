//
//  SpotlightImageIndexer.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 10.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDWebImageManager;
@class SDImageCache;
@protocol SpotlightEntityImageIndexer;

@interface SpotlightImageIndexer : NSObject

@property (nonatomic, strong) NSArray<id<SpotlightEntityImageIndexer>> *indexers;
@property (nonatomic, strong) SDImageCache *imageCache;
@property (nonatomic, strong) SDWebImageManager *imageManager;

- (void)startIndexImageForSpotlight;

@end
