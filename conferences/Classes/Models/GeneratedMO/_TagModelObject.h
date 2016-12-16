// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureModelObject;

@interface TagModelObjectID : NSManagedObjectID {}
@end

@interface _TagModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TagModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* slug;

@property (nonatomic, strong, nullable) NSString* tagId;

@property (nonatomic, strong, nullable) NSSet<LectureModelObject*> *lectures;
- (nullable NSMutableSet<LectureModelObject*>*)lecturesSet;

@end

@interface _TagModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<LectureModelObject*>*)value_;
- (void)removeLectures:(NSSet<LectureModelObject*>*)value_;
- (void)addLecturesObject:(LectureModelObject*)value_;
- (void)removeLecturesObject:(LectureModelObject*)value_;

@end

@interface _TagModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSlug;
- (void)setPrimitiveSlug:(NSString*)value;

- (NSString*)primitiveTagId;
- (void)setPrimitiveTagId:(NSString*)value;

- (NSMutableSet<LectureModelObject*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<LectureModelObject*>*)value;

@end

@interface TagModelObjectAttributes: NSObject 
+ (NSString *)name;
+ (NSString *)slug;
+ (NSString *)tagId;
@end

@interface TagModelObjectRelationships: NSObject
+ (NSString *)lectures;
@end

NS_ASSUME_NONNULL_END
