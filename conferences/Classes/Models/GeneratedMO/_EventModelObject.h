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

@class Lecture;
@class MetaEvent;
@class RegistrationQuestion;
@class Tag;
@class Tech;

@interface EventModelObjectID : NSManagedObjectID {}
@end

@interface _EventModelObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
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

@property (nonatomic, strong, nullable) NSString* liveStreamLink;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSDate* startDate;

@property (nonatomic, strong, nullable) NSString* timePadID;

@property (nonatomic, strong, nullable) NSString* twitterTag;

@property (nonatomic, strong, nullable) NSSet<Lecture*> *lectures;
- (nullable NSMutableSet<Lecture*>*)lecturesSet;

@property (nonatomic, strong, nullable) MetaEvent *metaEvent;

@property (nonatomic, strong, nullable) NSSet<RegistrationQuestion*> *registrationQuestions;
- (nullable NSMutableSet<RegistrationQuestion*>*)registrationQuestionsSet;

@property (nonatomic, strong, nullable) NSSet<Tag*> *tags;
- (nullable NSMutableSet<Tag*>*)tagsSet;

@property (nonatomic, strong, nullable) Tech *tech;

@end

@interface _EventModelObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<Lecture*>*)value_;
- (void)removeLectures:(NSSet<Lecture*>*)value_;
- (void)addLecturesObject:(Lecture*)value_;
- (void)removeLecturesObject:(Lecture*)value_;

@end

@interface _EventModelObject (RegistrationQuestionsCoreDataGeneratedAccessors)
- (void)addRegistrationQuestions:(NSSet<RegistrationQuestion*>*)value_;
- (void)removeRegistrationQuestions:(NSSet<RegistrationQuestion*>*)value_;
- (void)addRegistrationQuestionsObject:(RegistrationQuestion*)value_;
- (void)removeRegistrationQuestionsObject:(RegistrationQuestion*)value_;

@end

@interface _EventModelObject (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet<Tag*>*)value_;
- (void)removeTags:(NSSet<Tag*>*)value_;
- (void)addTagsObject:(Tag*)value_;
- (void)removeTagsObject:(Tag*)value_;

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

- (NSMutableSet<Lecture*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<Lecture*>*)value;

- (MetaEvent*)primitiveMetaEvent;
- (void)setPrimitiveMetaEvent:(MetaEvent*)value;

- (NSMutableSet<RegistrationQuestion*>*)primitiveRegistrationQuestions;
- (void)setPrimitiveRegistrationQuestions:(NSMutableSet<RegistrationQuestion*>*)value;

- (NSMutableSet<Tag*>*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet<Tag*>*)value;

- (Tech*)primitiveTech;
- (void)setPrimitiveTech:(Tech*)value;

@end

@interface EventModelObjectAttributes: NSObject 
+ (NSString *)endDate;
+ (NSString *)eventDescription;
+ (NSString *)eventId;
+ (NSString *)eventSubtitle;
+ (NSString *)eventType;
+ (NSString *)imageUrl;
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
+ (NSString *)tags;
+ (NSString *)tech;
@end

NS_ASSUME_NONNULL_END
