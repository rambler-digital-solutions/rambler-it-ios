// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MetaEventManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class EventManagedObject;

@interface MetaEventManagedObjectID : NSManagedObjectID {}
@end

@interface _MetaEventManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MetaEventManagedObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* imageUrlPath;

@property (nonatomic, strong, nullable) NSString* metaEventDescription;

@property (nonatomic, strong) NSString* metaEventId;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) NSString* websiteUrlPath;

@property (nonatomic, strong, nullable) NSSet<EventManagedObject*> *events;
- (nullable NSMutableSet<EventManagedObject*>*)eventsSet;

@end

@interface _MetaEventManagedObject (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet<EventManagedObject*>*)value_;
- (void)removeEvents:(NSSet<EventManagedObject*>*)value_;
- (void)addEventsObject:(EventManagedObject*)value_;
- (void)removeEventsObject:(EventManagedObject*)value_;

@end

@interface _MetaEventManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveImageUrlPath;
- (void)setPrimitiveImageUrlPath:(NSString*)value;

- (NSString*)primitiveMetaEventDescription;
- (void)setPrimitiveMetaEventDescription:(NSString*)value;

- (NSString*)primitiveMetaEventId;
- (void)setPrimitiveMetaEventId:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveWebsiteUrlPath;
- (void)setPrimitiveWebsiteUrlPath:(NSString*)value;

- (NSMutableSet<EventManagedObject*>*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet<EventManagedObject*>*)value;

@end

@interface MetaEventManagedObjectAttributes: NSObject 
+ (NSString *)imageUrlPath;
+ (NSString *)metaEventDescription;
+ (NSString *)metaEventId;
+ (NSString *)name;
+ (NSString *)websiteUrlPath;
@end

@interface MetaEventManagedObjectRelationships: NSObject
+ (NSString *)events;
@end

NS_ASSUME_NONNULL_END
