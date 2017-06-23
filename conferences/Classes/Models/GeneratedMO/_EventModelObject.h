// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventModelObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureModelObject;
@class MetaEventModelObject;
@class RegistrationQuestionModelObject;
@class TechModelObject;

@interface EventModelObjectID : NSManagedObjectID {}
@end

@interface _EventModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EventModelObjectID *objectID;

@property (nonatomic, strong) NSDate* endDate;

@property (nonatomic, strong, nullable) NSString* eventDescription;

@property (nonatomic, strong, nullable) NSString* eventId;

@property (nonatomic, strong, nullable) NSString* eventSubtitle;

@property (nonatomic, strong, nullable) NSNumber* eventType;

@property (atomic) int32_t eventTypeValue;
- (int32_t)eventTypeValue;
- (void)setEventTypeValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* imageUrl;

@property (nonatomic, strong, nullable) NSDate* lastVisitDate;

@property (nonatomic, strong, nullable) NSString* liveStreamLink;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSDate* startDate;

@property (nonatomic, strong, nullable) NSString* timePadID;

@property (nonatomic, strong, nullable) NSString* twitterTag;

@property (nonatomic, strong, nullable) NSOrderedSet<LectureModelObject*> *lectures;
- (nullable NSMutableOrderedSet<LectureModelObject*>*)lecturesSet;

@property (nonatomic, strong, nullable) MetaEventModelObject *metaEvent;

@property (nonatomic, strong, nullable) NSSet<RegistrationQuestionModelObject*> *registrationQuestions;
- (nullable NSMutableSet<RegistrationQuestionModelObject*>*)registrationQuestionsSet;

@property (nonatomic, strong, nullable) TechModelObject *tech;

@end

@interface _EventModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSOrderedSet<LectureModelObject*>*)value_;
- (void)removeLectures:(NSOrderedSet<LectureModelObject*>*)value_;
- (void)addLecturesObject:(LectureModelObject*)value_;
- (void)removeLecturesObject:(LectureModelObject*)value_;

- (void)insertObject:(LectureModelObject*)value inLecturesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLecturesAtIndex:(NSUInteger)idx;
- (void)insertLectures:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLecturesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLecturesAtIndex:(NSUInteger)idx withObject:(LectureModelObject*)value;
- (void)replaceLecturesAtIndexes:(NSIndexSet *)indexes withLectures:(NSArray *)values;

@end

@interface _EventModelObject (RegistrationQuestionsCoreDataGeneratedAccessors)
- (void)addRegistrationQuestions:(NSSet<RegistrationQuestionModelObject*>*)value_;
- (void)removeRegistrationQuestions:(NSSet<RegistrationQuestionModelObject*>*)value_;
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

- (NSMutableOrderedSet<LectureModelObject*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableOrderedSet<LectureModelObject*>*)value;

- (MetaEventModelObject*)primitiveMetaEvent;
- (void)setPrimitiveMetaEvent:(MetaEventModelObject*)value;

- (NSMutableSet<RegistrationQuestionModelObject*>*)primitiveRegistrationQuestions;
- (void)setPrimitiveRegistrationQuestions:(NSMutableSet<RegistrationQuestionModelObject*>*)value;

- (TechModelObject*)primitiveTech;
- (void)setPrimitiveTech:(TechModelObject*)value;

@end

@interface EventModelObjectAttributes: NSObject 
+ (NSString *)endDate;
+ (NSString *)eventDescription;
+ (NSString *)eventId;
+ (NSString *)eventSubtitle;
+ (NSString *)eventType;
+ (NSString *)imageUrl;
+ (NSString *)lastVisitDate;
+ (NSString *)liveStreamLink;
+ (NSString *)name;
+ (NSString *)startDate;
+ (NSString *)timePadID;
+ (NSString *)twitterTag;
@end

@interface EventModelObjectRelationships: NSObject
+ (NSString *)lectures;
+ (NSString *)metaEvent;
+ (NSString *)registrationQuestions;
+ (NSString *)tech;
@end

NS_ASSUME_NONNULL_END
