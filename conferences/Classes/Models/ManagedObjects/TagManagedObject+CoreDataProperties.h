//
//  TagManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TagManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *slug;
@property (nullable, nonatomic, retain) NSNumber *tagId;
@property (nullable, nonatomic, retain) NSSet<EventManagedObject *> *events;

@end

@interface TagManagedObject (CoreDataGeneratedAccessors)

- (void)addEventsObject:(EventManagedObject *)value;
- (void)removeEventsObject:(EventManagedObject *)value;
- (void)addEvents:(NSSet<EventManagedObject *> *)values;
- (void)removeEvents:(NSSet<EventManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
