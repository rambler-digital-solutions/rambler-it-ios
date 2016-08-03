// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventListModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface EventListModelObjectID : NSManagedObjectID {}
@end

@interface _EventListModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EventListModelObjectID *objectID;

@property (nonatomic, strong) NSString* eventListId;

@property (nonatomic, strong, nullable) NSDate* lastModified;

@property (nonatomic, strong, nullable) NSString* name;

@end

@interface _EventListModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveEventListId;
- (void)setPrimitiveEventListId:(NSString*)value;

- (NSDate*)primitiveLastModified;
- (void)setPrimitiveLastModified:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

@interface EventListModelObjectAttributes: NSObject 
+ (NSString *)eventListId;
+ (NSString *)lastModified;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
