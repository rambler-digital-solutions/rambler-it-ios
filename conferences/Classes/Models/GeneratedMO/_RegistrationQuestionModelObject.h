// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RegistrationQuestionModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Event;

@interface RegistrationQuestionModelObjectID : NSManagedObjectID {}
@end

@interface _RegistrationQuestionModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RegistrationQuestionModelObjectID *objectID;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* orderID;

@property (nonatomic, strong, nullable) Event *event;

@end

@interface _RegistrationQuestionModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveOrderID;
- (void)setPrimitiveOrderID:(NSString*)value;

- (Event*)primitiveEvent;
- (void)setPrimitiveEvent:(Event*)value;

@end

@interface RegistrationQuestionModelObjectAttributes: NSObject 
+ (NSString *)name;
+ (NSString *)orderID;
@end

@interface RegistrationQuestionModelObjectRelationships: NSObject
+ (NSString *)event;
@end

NS_ASSUME_NONNULL_END
