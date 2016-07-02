//
//  MetaEventManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MetaEventManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MetaEventManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageUrlPath;
@property (nullable, nonatomic, retain) NSString *metaEventDescription;
@property (nullable, nonatomic, retain) NSString *metaEventId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *websiteUrlPath;
@property (nullable, nonatomic, retain) NSSet<EventManagedObject *> *events;

@end

@interface MetaEventManagedObject (CoreDataGeneratedAccessors)

- (void)addEventsObject:(EventManagedObject *)value;
- (void)removeEventsObject:(EventManagedObject *)value;
- (void)addEvents:(NSSet<EventManagedObject *> *)values;
- (void)removeEvents:(NSSet<EventManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
