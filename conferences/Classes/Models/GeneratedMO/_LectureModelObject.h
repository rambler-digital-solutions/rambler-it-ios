// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Event;
@class LectureMaterial;
@class Speaker;
@class Tag;

@interface LectureModelObjectID : NSManagedObjectID {}
@end

@interface _LectureModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LectureModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSNumber* favourite;

@property (atomic) BOOL favouriteValue;
- (BOOL)favouriteValue;
- (void)setFavouriteValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* lectureDescription;

@property (nonatomic, strong) NSString* lectureId;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) Event *event;

@property (nonatomic, strong, nullable) NSSet<LectureMaterial*> *lectureMaterials;
- (nullable NSMutableSet<LectureMaterial*>*)lectureMaterialsSet;

@property (nonatomic, strong, nullable) Speaker *speaker;

@property (nonatomic, strong, nullable) NSSet<Tag*> *tags;
- (nullable NSMutableSet<Tag*>*)tagsSet;

@end

@interface _LectureModelObject (LectureMaterialsCoreDataGeneratedAccessors)
- (void)addLectureMaterials:(NSSet<LectureMaterial*>*)value_;
- (void)removeLectureMaterials:(NSSet<LectureMaterial*>*)value_;
- (void)addLectureMaterialsObject:(LectureMaterial*)value_;
- (void)removeLectureMaterialsObject:(LectureMaterial*)value_;

@end

@interface _LectureModelObject (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet<Tag*>*)value_;
- (void)removeTags:(NSSet<Tag*>*)value_;
- (void)addTagsObject:(Tag*)value_;
- (void)removeTagsObject:(Tag*)value_;

@end

@interface _LectureModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveFavourite;
- (void)setPrimitiveFavourite:(NSNumber*)value;

- (BOOL)primitiveFavouriteValue;
- (void)setPrimitiveFavouriteValue:(BOOL)value_;

- (NSString*)primitiveLectureDescription;
- (void)setPrimitiveLectureDescription:(NSString*)value;

- (NSString*)primitiveLectureId;
- (void)setPrimitiveLectureId:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (Event*)primitiveEvent;
- (void)setPrimitiveEvent:(Event*)value;

- (NSMutableSet<LectureMaterial*>*)primitiveLectureMaterials;
- (void)setPrimitiveLectureMaterials:(NSMutableSet<LectureMaterial*>*)value;

- (Speaker*)primitiveSpeaker;
- (void)setPrimitiveSpeaker:(Speaker*)value;

- (NSMutableSet<Tag*>*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet<Tag*>*)value;

@end

@interface LectureModelObjectAttributes: NSObject 
+ (NSString *)favourite;
+ (NSString *)lectureDescription;
+ (NSString *)lectureId;
+ (NSString *)name;
@end

@interface LectureModelObjectRelationships: NSObject
+ (NSString *)event;
+ (NSString *)lectureMaterials;
+ (NSString *)speaker;
+ (NSString *)tags;
@end

NS_ASSUME_NONNULL_END
