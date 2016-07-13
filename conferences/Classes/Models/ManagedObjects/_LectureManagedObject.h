// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class EventManagedObject;
@class LectureMaterialManagedObject;
@class SpeakerManagedObject;
@class TagManagedObject;

@interface LectureManagedObjectID : NSManagedObjectID {}
@end

@interface _LectureManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LectureManagedObjectID *objectID;

@property (nonatomic, strong, nullable) NSNumber* favourite;

@property (atomic) BOOL favouriteValue;
- (BOOL)favouriteValue;
- (void)setFavouriteValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* lectureDescription;

@property (nonatomic, strong) NSString* lectureId;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong, nullable) EventManagedObject *event;

@property (nonatomic, strong, nullable) NSSet<LectureMaterialManagedObject*> *lectureMaterials;
- (nullable NSMutableSet<LectureMaterialManagedObject*>*)lectureMaterialsSet;

@property (nonatomic, strong, nullable) SpeakerManagedObject *speaker;

@property (nonatomic, strong, nullable) NSSet<TagManagedObject*> *tags;
- (nullable NSMutableSet<TagManagedObject*>*)tagsSet;

@end

@interface _LectureManagedObject (LectureMaterialsCoreDataGeneratedAccessors)
- (void)addLectureMaterials:(NSSet<LectureMaterialManagedObject*>*)value_;
- (void)removeLectureMaterials:(NSSet<LectureMaterialManagedObject*>*)value_;
- (void)addLectureMaterialsObject:(LectureMaterialManagedObject*)value_;
- (void)removeLectureMaterialsObject:(LectureMaterialManagedObject*)value_;

@end

@interface _LectureManagedObject (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet<TagManagedObject*>*)value_;
- (void)removeTags:(NSSet<TagManagedObject*>*)value_;
- (void)addTagsObject:(TagManagedObject*)value_;
- (void)removeTagsObject:(TagManagedObject*)value_;

@end

@interface _LectureManagedObject (CoreDataGeneratedPrimitiveAccessors)

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

- (EventManagedObject*)primitiveEvent;
- (void)setPrimitiveEvent:(EventManagedObject*)value;

- (NSMutableSet<LectureMaterialManagedObject*>*)primitiveLectureMaterials;
- (void)setPrimitiveLectureMaterials:(NSMutableSet<LectureMaterialManagedObject*>*)value;

- (SpeakerManagedObject*)primitiveSpeaker;
- (void)setPrimitiveSpeaker:(SpeakerManagedObject*)value;

- (NSMutableSet<TagManagedObject*>*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet<TagManagedObject*>*)value;

@end

@interface LectureManagedObjectAttributes: NSObject 
+ (NSString *)favourite;
+ (NSString *)lectureDescription;
+ (NSString *)lectureId;
+ (NSString *)name;
@end

@interface LectureManagedObjectRelationships: NSObject
+ (NSString *)event;
+ (NSString *)lectureMaterials;
+ (NSString *)speaker;
+ (NSString *)tags;
@end

NS_ASSUME_NONNULL_END
