// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LastModifiedModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface LastModifiedModelObjectID : NSManagedObjectID {}
@end

@interface _LastModifiedModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LastModifiedModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSDate* lastModifiedDate;

@property (nonatomic, strong) NSString* lastModifiedId;

@property (nonatomic, strong, nullable) NSString* name;

@end

@interface _LastModifiedModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveLastModifiedDate;
- (void)setPrimitiveLastModifiedDate:(NSDate*)value;

- (NSString*)primitiveLastModifiedId;
- (void)setPrimitiveLastModifiedId:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

@interface LastModifiedModelObjectAttributes: NSObject 
+ (NSString *)lastModifiedDate;
+ (NSString *)lastModifiedId;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
