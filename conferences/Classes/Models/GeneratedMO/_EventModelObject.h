// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventModelObject.h instead.

#import <CoreData/CoreData.h>

extern const struct EventModelObjectAttributes {
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *eventDescription;
	__unsafe_unretained NSString *eventId;
	__unsafe_unretained NSString *eventSubtitle;
	__unsafe_unretained NSString *eventType;
	__unsafe_unretained NSString *imageUrl;
	__unsafe_unretained NSString *lastVisitDate;
	__unsafe_unretained NSString *liveStreamLink;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *startDate;
	__unsafe_unretained NSString *timePadID;
	__unsafe_unretained NSString *twitterTag;
} EventModelObjectAttributes;

extern const struct EventModelObjectRelationships {
	__unsafe_unretained NSString *lectures;
	__unsafe_unretained NSString *metaEvent;
	__unsafe_unretained NSString *registrationQuestions;
	__unsafe_unretained NSString *tech;
} EventModelObjectRelationships;

@class LectureModelObject;
@class MetaEventModelObject;
@class RegistrationQuestionModelObject;
@class TechModelObject;

@interface EventModelObjectID : NSManagedObjectID {}
@end

@interface _EventModelObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EventModelObjectID* objectID;

@property (nonatomic, strong) NSDate* endDate;

//- (BOOL)validateEndDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* eventDescription;

//- (BOOL)validateEventDescription:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* eventId;

//- (BOOL)validateEventId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* eventSubtitle;

//- (BOOL)validateEventSubtitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* eventType;

@property (atomic) int32_t eventTypeValue;
- (int32_t)eventTypeValue;
- (void)setEventTypeValue:(int32_t)value_;

//- (BOOL)validateEventType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageUrl;

//- (BOOL)validateImageUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* lastVisitDate;

//- (BOOL)validateLastVisitDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* liveStreamLink;

//- (BOOL)validateLiveStreamLink:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* startDate;

//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* timePadID;

//- (BOOL)validateTimePadID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* twitterTag;

//- (BOOL)validateTwitterTag:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *lectures;

- (NSMutableSet*)lecturesSet;

@property (nonatomic, strong) MetaEventModelObject *metaEvent;

//- (BOOL)validateMetaEvent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *registrationQuestions;

- (NSMutableSet*)registrationQuestionsSet;

@property (nonatomic, strong) TechModelObject *tech;

//- (BOOL)validateTech:(id*)value_ error:(NSError**)error_;

@end

@interface _EventModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet*)value_;
- (void)removeLectures:(NSSet*)value_;
- (void)addLecturesObject:(LectureModelObject*)value_;
- (void)removeLecturesObject:(LectureModelObject*)value_;

@end

@interface _EventModelObject (RegistrationQuestionsCoreDataGeneratedAccessors)
- (void)addRegistrationQuestions:(NSSet*)value_;
- (void)removeRegistrationQuestions:(NSSet*)value_;
- (void)addRegistrationQuestionsObject:(RegistrationQuestionModelObject*)value_;
- (void)removeRegistrationQuestionsObject:(RegistrationQuestionModelObject*)value_;

@end

@interface _EventModelObject (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSDate*)value;

- (NSString*)primitiveEventDescription;
- (void)setPrimitiveEventDescription:(NSString*)value;

- (NSString*)primitiveEventId;
- (void)setPrimitiveEventId:(NSString*)value;

- (NSString*)primitiveEventSubtitle;
- (void)setPrimitiveEventSubtitle:(NSString*)value;

- (NSNumber*)primitiveEventType;
- (void)setPrimitiveEventType:(NSNumber*)value;

- (int32_t)primitiveEventTypeValue;
- (void)setPrimitiveEventTypeValue:(int32_t)value_;

- (NSString*)primitiveImageUrl;
- (void)setPrimitiveImageUrl:(NSString*)value;

- (NSDate*)primitiveLastVisitDate;
- (void)setPrimitiveLastVisitDate:(NSDate*)value;

- (NSString*)primitiveLiveStreamLink;
- (void)setPrimitiveLiveStreamLink:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSDate*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSDate*)value;

- (NSString*)primitiveTimePadID;
- (void)setPrimitiveTimePadID:(NSString*)value;

- (NSString*)primitiveTwitterTag;
- (void)setPrimitiveTwitterTag:(NSString*)value;

- (NSMutableSet*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet*)value;

- (MetaEventModelObject*)primitiveMetaEvent;
- (void)setPrimitiveMetaEvent:(MetaEventModelObject*)value;

- (NSMutableSet*)primitiveRegistrationQuestions;
- (void)setPrimitiveRegistrationQuestions:(NSMutableSet*)value;

- (TechModelObject*)primitiveTech;
- (void)setPrimitiveTech:(TechModelObject*)value;

@end
