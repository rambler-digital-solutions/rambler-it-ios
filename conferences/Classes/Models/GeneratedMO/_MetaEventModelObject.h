// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MetaEventModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct MetaEventModelObjectAttributes {
	__unsafe_unretained NSString *imageUrlPath;
	__unsafe_unretained NSString *metaEventDescription;
	__unsafe_unretained NSString *metaEventId;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *websiteUrlPath;
} MetaEventModelObjectAttributes;

extern const struct MetaEventModelObjectRelationships {
	__unsafe_unretained NSString *events;
} MetaEventModelObjectRelationships;

@class EventModelObject;

@interface MetaEventModelObjectID : NSManagedObjectID {}
@end

@interface _MetaEventModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MetaEventModelObjectID* objectID;

@property (nonatomic, strong) NSString* imageUrlPath;

//- (BOOL)validateImageUrlPath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* metaEventDescription;

//- (BOOL)validateMetaEventDescription:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* metaEventId;

//- (BOOL)validateMetaEventId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* websiteUrlPath;

//- (BOOL)validateWebsiteUrlPath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *events;

- (NSMutableSet*)eventsSet;

@end

@interface _MetaEventModelObject (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet*)value_;
- (void)removeEvents:(NSSet*)value_;
- (void)addEventsObject:(EventModelObject*)value_;
- (void)removeEventsObject:(EventModelObject*)value_;

@end

@interface _MetaEventModelObject (CoreDataGeneratedPrimitiveAccessors)

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

- (NSMutableSet*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet*)value;

@end
