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

@class EventModelObject;
@class LectureMaterialModelObject;
@class SpeakerModelObject;
@class TagModelObject;

@interface LectureModelObjectID : NSManagedObjectID {}
@end

@interface _LectureModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LectureModelObjectID *objectID;

@property (nonatomic, strong, nullable) NSNumber* favourite;

@property (atomic) BOOL favouriteValue;
- (BOOL)favouriteValue;
- (void)setFavouriteValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* lectureDescription;

@property (nonatomic, strong) NSString* lectureId;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) EventModelObject *event;

@property (nonatomic, strong, nullable) NSSet<LectureMaterialModelObject*> *lectureMaterials;
- (nullable NSMutableSet<LectureMaterialModelObject*>*)lectureMaterialsSet;

@property (nonatomic, strong, nullable) SpeakerModelObject *speaker;

@property (nonatomic, strong, nullable) NSSet<TagModelObject*> *tags;
- (nullable NSMutableSet<TagModelObject*>*)tagsSet;

@end

@interface _LectureModelObject (LectureMaterialsCoreDataGeneratedAccessors)
- (void)addLectureMaterials:(NSSet<LectureMaterialModelObject*>*)value_;
- (void)removeLectureMaterials:(NSSet<LectureMaterialModelObject*>*)value_;
- (void)addLectureMaterialsObject:(LectureMaterialModelObject*)value_;
- (void)removeLectureMaterialsObject:(LectureMaterialModelObject*)value_;

@end

@interface _LectureModelObject (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet<TagModelObject*>*)value_;
- (void)removeTags:(NSSet<TagModelObject*>*)value_;
- (void)addTagsObject:(TagModelObject*)value_;
- (void)removeTagsObject:(TagModelObject*)value_;

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

- (EventModelObject*)primitiveEvent;
- (void)setPrimitiveEvent:(EventModelObject*)value;

- (NSMutableSet<LectureMaterialModelObject*>*)primitiveLectureMaterials;
- (void)setPrimitiveLectureMaterials:(NSMutableSet<LectureMaterialModelObject*>*)value;

- (SpeakerModelObject*)primitiveSpeaker;
- (void)setPrimitiveSpeaker:(SpeakerModelObject*)value;

- (NSMutableSet<TagModelObject*>*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet<TagModelObject*>*)value;

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
