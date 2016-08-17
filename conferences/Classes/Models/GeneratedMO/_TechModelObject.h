// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TechModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class EventModelObject;

@interface TechModelObjectID : NSManagedObjectID {}
@end

@interface _TechModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TechModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* color;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* techId;

@property (nonatomic, strong, nullable) NSSet<EventModelObject*> *events;
- (nullable NSMutableSet<EventModelObject*>*)eventsSet;

@end

@interface _TechModelObject (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet<EventModelObject*>*)value_;
- (void)removeEvents:(NSSet<EventModelObject*>*)value_;
- (void)addEventsObject:(EventModelObject*)value_;
- (void)removeEventsObject:(EventModelObject*)value_;

@end

@interface _TechModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveColor;
- (void)setPrimitiveColor:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveTechId;
- (void)setPrimitiveTechId:(NSString*)value;

- (NSMutableSet<EventModelObject*>*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet<EventModelObject*>*)value;

@end

@interface TechModelObjectAttributes: NSObject 
+ (NSString *)color;
+ (NSString *)name;
+ (NSString *)techId;
@end

@interface TechModelObjectRelationships: NSObject
+ (NSString *)events;
@end

NS_ASSUME_NONNULL_END
