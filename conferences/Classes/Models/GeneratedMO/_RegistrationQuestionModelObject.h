// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RegistrationQuestionModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct RegistrationQuestionModelObjectAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *orderID;
} RegistrationQuestionModelObjectAttributes;

extern const struct RegistrationQuestionModelObjectRelationships {
	__unsafe_unretained NSString *event;
} RegistrationQuestionModelObjectRelationships;

@class EventModelObject;

@interface RegistrationQuestionModelObjectID : NSManagedObjectID {}
@end

@interface _RegistrationQuestionModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RegistrationQuestionModelObjectID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* orderID;

//- (BOOL)validateOrderID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) EventModelObject *event;

//- (BOOL)validateEvent:(id*)value_ error:(NSError**)error_;

@end

@interface _RegistrationQuestionModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveOrderID;
- (void)setPrimitiveOrderID:(NSString*)value;

- (EventModelObject*)primitiveEvent;
- (void)setPrimitiveEvent:(EventModelObject*)value;

@end
