// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct LectureModelObjectAttributes {
	__unsafe_unretained NSString *favourite;
	__unsafe_unretained NSString *lectureDescription;
	__unsafe_unretained NSString *lectureId;
	__unsafe_unretained NSString *name;
} LectureModelObjectAttributes;

extern const struct LectureModelObjectRelationships {
	__unsafe_unretained NSString *event;
	__unsafe_unretained NSString *lectureMaterials;
	__unsafe_unretained NSString *speaker;
	__unsafe_unretained NSString *tags;
} LectureModelObjectRelationships;

@class EventModelObject;
@class LectureMaterialModelObject;
@class SpeakerModelObject;
@class TagModelObject;

@interface LectureModelObjectID : NSManagedObjectID {}
@end

@interface _LectureModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LectureModelObjectID* objectID;

@property (nonatomic, strong) NSNumber* favourite;

@property (atomic) BOOL favouriteValue;
- (BOOL)favouriteValue;
- (void)setFavouriteValue:(BOOL)value_;

//- (BOOL)validateFavourite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lectureDescription;

//- (BOOL)validateLectureDescription:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lectureId;

//- (BOOL)validateLectureId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) EventModelObject *event;

//- (BOOL)validateEvent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *lectureMaterials;

- (NSMutableSet*)lectureMaterialsSet;

@property (nonatomic, strong) SpeakerModelObject *speaker;

//- (BOOL)validateSpeaker:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _LectureModelObject (LectureMaterialsCoreDataGeneratedAccessors)
- (void)addLectureMaterials:(NSSet*)value_;
- (void)removeLectureMaterials:(NSSet*)value_;
- (void)addLectureMaterialsObject:(LectureMaterialModelObject*)value_;
- (void)removeLectureMaterialsObject:(LectureMaterialModelObject*)value_;

@end

@interface _LectureModelObject (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
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

- (NSMutableSet*)primitiveLectureMaterials;
- (void)setPrimitiveLectureMaterials:(NSMutableSet*)value;

- (SpeakerModelObject*)primitiveSpeaker;
- (void)setPrimitiveSpeaker:(SpeakerModelObject*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
