//
//  IndexState+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IndexState.h"

NS_ASSUME_NONNULL_BEGIN

@interface IndexState (CoreDataProperties)

@property (nullable, nonatomic, retain) NSMutableOrderedSet *deleteIdentifiers;
@property (nullable, nonatomic, retain) NSMutableOrderedSet *insertIdentifiers;
@property (nullable, nonatomic, retain) NSMutableOrderedSet *updateIdentifiers;
@property (nullable, nonatomic, retain) NSMutableOrderedSet *moveIdentifiers;
@property (nullable, nonatomic, retain) NSDate *lastChangeDate;
@property (nullable, nonatomic, retain) NSNumber *numberOfIdentifiers;
@property (nullable, nonatomic, retain) NSString *objectType;

@end

NS_ASSUME_NONNULL_END
