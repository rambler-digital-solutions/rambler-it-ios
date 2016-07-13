// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RegistrationQuestionManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class EventManagedObject;

@interface RegistrationQuestionManagedObjectID : NSManagedObjectID {}
@end

@interface _RegistrationQuestionManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RegistrationQuestionManagedObjectID *objectID;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* orderID;

@property (nonatomic, strong, nullable) EventManagedObject *event;

@end

@interface _RegistrationQuestionManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveOrderID;
- (void)setPrimitiveOrderID:(NSString*)value;

- (EventManagedObject*)primitiveEvent;
- (void)setPrimitiveEvent:(EventManagedObject*)value;

@end

@interface RegistrationQuestionManagedObjectAttributes: NSObject 
+ (NSString *)name;
+ (NSString *)orderID;
@end

@interface RegistrationQuestionManagedObjectRelationships: NSObject
+ (NSString *)event;
@end

NS_ASSUME_NONNULL_END
