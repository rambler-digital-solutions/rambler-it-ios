// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EventManagedObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LectureManagedObject;
@class MetaEventManagedObject;
@class RegistrationQuestionManagedObject;
@class TechManagedObject;

@interface EventManagedObjectID : NSManagedObjectID {}
@end

@interface _EventManagedObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EventManagedObjectID *objectID;

@property (nonatomic, strong) NSDate* endDate;

@property (nonatomic, strong, nullable) NSString* eventId;

@property (nonatomic, strong, nullable) NSString* liveStreamLink;

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSDate* startDate;

@property (nonatomic, strong, nullable) NSString* timePadID;

@property (nonatomic, strong, nullable) NSString* twitterTag;

@property (nonatomic, strong, nullable) NSSet<LectureManagedObject*> *lectures;
- (nullable NSMutableSet<LectureManagedObject*>*)lecturesSet;

@property (nonatomic, strong, nullable) MetaEventManagedObject *metaEvent;

@property (nonatomic, strong, nullable) NSSet<RegistrationQuestionManagedObject*> *registrationQuestions;
- (nullable NSMutableSet<RegistrationQuestionManagedObject*>*)registrationQuestionsSet;

@property (nonatomic, strong, nullable) TechManagedObject *tech;

@end

@interface _EventManagedObject (LecturesCoreDataGeneratedAccessors)
- (void)addLectures:(NSSet<LectureManagedObject*>*)value_;
- (void)removeLectures:(NSSet<LectureManagedObject*>*)value_;
- (void)addLecturesObject:(LectureManagedObject*)value_;
- (void)removeLecturesObject:(LectureManagedObject*)value_;

@end

@interface _EventManagedObject (RegistrationQuestionsCoreDataGeneratedAccessors)
- (void)addRegistrationQuestions:(NSSet<RegistrationQuestionManagedObject*>*)value_;
- (void)removeRegistrationQuestions:(NSSet<RegistrationQuestionManagedObject*>*)value_;
- (void)addRegistrationQuestionsObject:(RegistrationQuestionManagedObject*)value_;
- (void)removeRegistrationQuestionsObject:(RegistrationQuestionManagedObject*)value_;

@end

@interface _EventManagedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSDate*)value;

- (NSString*)primitiveEventId;
- (void)setPrimitiveEventId:(NSString*)value;

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

- (NSMutableSet<LectureManagedObject*>*)primitiveLectures;
- (void)setPrimitiveLectures:(NSMutableSet<LectureManagedObject*>*)value;

- (MetaEventManagedObject*)primitiveMetaEvent;
- (void)setPrimitiveMetaEvent:(MetaEventManagedObject*)value;

- (NSMutableSet<RegistrationQuestionManagedObject*>*)primitiveRegistrationQuestions;
- (void)setPrimitiveRegistrationQuestions:(NSMutableSet<RegistrationQuestionManagedObject*>*)value;

- (TechManagedObject*)primitiveTech;
- (void)setPrimitiveTech:(TechManagedObject*)value;

@end

@interface EventManagedObjectAttributes: NSObject 
+ (NSString *)endDate;
+ (NSString *)eventId;
+ (NSString *)liveStreamLink;
+ (NSString *)name;
+ (NSString *)startDate;
+ (NSString *)timePadID;
+ (NSString *)twitterTag;
@end

@interface EventManagedObjectRelationships: NSObject
+ (NSString *)lectures;
+ (NSString *)metaEvent;
+ (NSString *)registrationQuestions;
+ (NSString *)tech;
@end

NS_ASSUME_NONNULL_END
