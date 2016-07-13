// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureMaterialManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureManagedObject;

@interface LectureMaterialManagedObjectID : NSManagedObjectID {}
@end

@interface _LectureMaterialManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LectureMaterialManagedObjectID *objectID;

@property (nonatomic, strong) NSString* lectureMaterialId;

@property (nonatomic, strong) NSString* link;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) LectureManagedObject *lecture;

@end

@interface _LectureMaterialManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveLectureMaterialId;
- (void)setPrimitiveLectureMaterialId:(NSString*)value;

- (NSString*)primitiveLink;
- (void)setPrimitiveLink:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (LectureManagedObject*)primitiveLecture;
- (void)setPrimitiveLecture:(LectureManagedObject*)value;

@end

@interface LectureMaterialManagedObjectAttributes: NSObject 
+ (NSString *)lectureMaterialId;
+ (NSString *)link;
+ (NSString *)name;
@end

@interface LectureMaterialManagedObjectRelationships: NSObject
+ (NSString *)lecture;
@end

NS_ASSUME_NONNULL_END
