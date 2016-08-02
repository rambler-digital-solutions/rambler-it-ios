//
//  IndexState.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndexState : NSManagedObject

- (void)insertIdentifier:(NSString *)identifier
                 forType:(NSUInteger)type;

- (void)removeIdentifier:(NSString *)identifier
                 forType:(NSUInteger)type;

- (void)insertIdentifiers:(NSArray *)identifiers
                  forType:(NSUInteger)type;

- (void)removeIdentifiers:(NSArray *)identifiers
                  forType:(NSUInteger)type;

- (NSUInteger)typeForIdentifiersSet:(NSMutableOrderedSet *)identifiersSet;

- (NSMutableOrderedSet *)identifiersSetForType:(NSUInteger)type;

@end

NS_ASSUME_NONNULL_END

#import "IndexState+CoreDataProperties.h"
