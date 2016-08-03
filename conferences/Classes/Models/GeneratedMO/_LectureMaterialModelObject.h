// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureMaterialModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureModelObject;

@interface LectureMaterialModelObjectID : NSManagedObjectID {}
@end

@interface _LectureMaterialModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LectureMaterialModelObjectID *objectID;

@property (nonatomic, strong) NSString* lectureMaterialId;

@property (nonatomic, strong) NSString* link;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) LectureModelObject *lecture;

@end

@interface _LectureMaterialModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveLectureMaterialId;
- (void)setPrimitiveLectureMaterialId:(NSString*)value;

- (NSString*)primitiveLink;
- (void)setPrimitiveLink:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (LectureModelObject*)primitiveLecture;
- (void)setPrimitiveLecture:(LectureModelObject*)value;

@end

@interface LectureMaterialModelObjectAttributes: NSObject 
+ (NSString *)lectureMaterialId;
+ (NSString *)link;
+ (NSString *)name;
@end

@interface LectureMaterialModelObjectRelationships: NSObject
+ (NSString *)lecture;
@end

NS_ASSUME_NONNULL_END
