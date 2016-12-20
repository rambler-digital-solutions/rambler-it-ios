//
//  SpeakerImageIndexer.h
//  Conferences
//
//  Created by Konstantin Zinovyev on 12.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectImageIndexer.h"

@class CSSearchableIndex;
@class SpeakerObjectIndexer;

/**
 @author Konstantin Zinovyev
 
 ImageIndexer for Speaker model object
 */
@interface SpeakerImageIndexer : NSObject <ObjectImageIndexer>

@property (nonatomic, strong) CSSearchableIndex *searchableIndex;
@property (nonatomic, strong) SpeakerObjectIndexer *indexer;

@end
