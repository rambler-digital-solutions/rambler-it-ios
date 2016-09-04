// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LectureMaterialModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct LectureMaterialModelObjectAttributes {
	__unsafe_unretained NSString *lectureMaterialId;
	__unsafe_unretained NSString *link;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *type;
} LectureMaterialModelObjectAttributes;

extern const struct LectureMaterialModelObjectRelationships {
	__unsafe_unretained NSString *lecture;
} LectureMaterialModelObjectRelationships;

@class LectureModelObject;

@interface LectureMaterialModelObjectID : NSManagedObjectID {}
@end

@interface _LectureMaterialModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LectureMaterialModelObjectID* objectID;

@property (nonatomic, strong) NSString* lectureMaterialId;

//- (BOOL)validateLectureMaterialId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* link;

//- (BOOL)validateLink:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* type;

@property (atomic) int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LectureModelObject *lecture;

//- (BOOL)validateLecture:(id*)value_ error:(NSError**)error_;

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
