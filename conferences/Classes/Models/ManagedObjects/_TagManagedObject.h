// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureManagedObject;

@interface TagManagedObjectID : NSManagedObjectID {}
@end

@interface _TagManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TagManagedObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* slug;

@property (nonatomic, strong, nullable) NSString* tagId;

@property (nonatomic, strong, nullable) NSSet<LectureManagedObject*> *lectures;
- (nullable NSMutableSet<LectureManagedObject*>*)lecturesSet;

@end

@interface _TagManagedObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<LectureManagedObject*>*)value_;
- (void)removeLectures:(NSSet<LectureManagedObject*>*)value_;
- (void)addLecturesObject:(LectureManagedObject*)value_;
- (void)removeLecturesObject:(LectureManagedObject*)value_;

@end

@interface _TagManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSlug;
- (void)setPrimitiveSlug:(NSString*)value;

- (NSString*)primitiveTagId;
- (void)setPrimitiveTagId:(NSString*)value;

- (NSMutableSet<LectureManagedObject*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<LectureManagedObject*>*)value;

@end

@interface TagManagedObjectAttributes: NSObject 
+ (NSString *)name;
+ (NSString *)slug;
+ (NSString *)tagId;
@end

@interface TagManagedObjectRelationships: NSObject
+ (NSString *)lectures;
@end

NS_ASSUME_NONNULL_END
