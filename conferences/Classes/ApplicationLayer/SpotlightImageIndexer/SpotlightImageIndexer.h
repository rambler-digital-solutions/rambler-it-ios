//
//  SpotlightImageIndexer.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 10.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectImageIndexer;
@interface SpotlightImageIndexer : NSObject

@property (nonatomic, strong) NSArray<id<ObjectImageIndexer>> *indexers;

- (void)startIndexImageForSpotlight;

@end
