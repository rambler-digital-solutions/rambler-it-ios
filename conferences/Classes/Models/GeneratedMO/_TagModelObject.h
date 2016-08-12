// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct TagModelObjectAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *slug;
	__unsafe_unretained NSString *tagId;
} TagModelObjectAttributes;

extern const struct TagModelObjectRelationships {
	__unsafe_unretained NSString *event;
	__unsafe_unretained NSString *lectures;
} TagModelObjectRelationships;

@class EventModelObject;
@class LectureModelObject;

@interface TagModelObjectID : NSManagedObjectID {}
@end

@interface _TagModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TagModelObjectID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* slug;

//- (BOOL)validateSlug:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* tagId;

//- (BOOL)validateTagId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) EventModelObject *event;

//- (BOOL)validateEvent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *lectures;

- (NSMutableSet*)lecturesSet;

@end

@interface _TagModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet*)value_;
- (void)removeLectures:(NSSet*)value_;
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

- (EventModelObject*)primitiveEvent;
- (void)setPrimitiveEvent:(EventModelObject*)value;

- (NSMutableSet*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet*)value;

@end
