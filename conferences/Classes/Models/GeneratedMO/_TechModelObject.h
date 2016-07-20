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

@class Event;

@interface TechModelObjectID : NSManagedObjectID {}
@end

@interface _TechModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TechModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* color;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* techId;

@property (nonatomic, strong, nullable) NSSet<Event*> *events;
- (nullable NSMutableSet<Event*>*)eventsSet;

@end

@interface _TechModelObject (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet<Event*>*)value_;
- (void)removeEvents:(NSSet<Event*>*)value_;
- (void)addEventsObject:(Event*)value_;
- (void)removeEventsObject:(Event*)value_;

@end

@interface _TechModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveColor;
- (void)setPrimitiveColor:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveTechId;
- (void)setPrimitiveTechId:(NSString*)value;

- (NSMutableSet<Event*>*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet<Event*>*)value;

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
