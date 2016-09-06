// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TechModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct TechModelObjectAttributes {
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *techId;
} TechModelObjectAttributes;

extern const struct TechModelObjectRelationships {
	__unsafe_unretained NSString *events;
} TechModelObjectRelationships;

@class EventModelObject;

@interface TechModelObjectID : NSManagedObjectID {}
@end

@interface _TechModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TechModelObjectID* objectID;

@property (nonatomic, strong) NSString* color;

//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* techId;

//- (BOOL)validateTechId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *events;

- (NSMutableSet*)eventsSet;

@end

@interface _TechModelObject (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet*)value_;
- (void)removeEvents:(NSSet*)value_;
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

- (NSMutableSet*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet*)value;

@end
