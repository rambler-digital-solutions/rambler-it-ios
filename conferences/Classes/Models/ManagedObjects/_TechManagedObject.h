// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TechManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class EventManagedObject;

@interface TechManagedObjectID : NSManagedObjectID {}
@end

@interface _TechManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TechManagedObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* color;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* techId;

@property (nonatomic, strong, nullable) NSSet<EventManagedObject*> *events;
- (nullable NSMutableSet<EventManagedObject*>*)eventsSet;

@end

@interface _TechManagedObject (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet<EventManagedObject*>*)value_;
- (void)removeEvents:(NSSet<EventManagedObject*>*)value_;
- (void)addEventsObject:(EventManagedObject*)value_;
- (void)removeEventsObject:(EventManagedObject*)value_;

@end

@interface _TechManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveColor;
- (void)setPrimitiveColor:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveTechId;
- (void)setPrimitiveTechId:(NSString*)value;

- (NSMutableSet<EventManagedObject*>*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet<EventManagedObject*>*)value;

@end

@interface TechManagedObjectAttributes: NSObject 
+ (NSString *)color;
+ (NSString *)name;
+ (NSString *)techId;
@end

@interface TechManagedObjectRelationships: NSObject
+ (NSString *)events;
@end

NS_ASSUME_NONNULL_END
