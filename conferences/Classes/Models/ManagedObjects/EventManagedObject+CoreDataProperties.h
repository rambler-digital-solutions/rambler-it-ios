//
//  EventManagedObject+CoreDataProperties.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSString *eventId;
@property (nullable, nonatomic, retain) NSString *liveStreamLink;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSString *timePadID;
@property (nullable, nonatomic, retain) NSString *twitterTag;
@property (nullable, nonatomic, retain) NSSet<LectureManagedObject *> *lectures;
@property (nullable, nonatomic, retain) MetaEventManagedObject *metaEvent;
@property (nullable, nonatomic, retain) NSSet<RegistrationQuestionManagedObject *> *registrationQuestions;
@property (nullable, nonatomic, retain) TechManagedObject *tech;

@end

@interface EventManagedObject (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(LectureManagedObject *)value;
- (void)removeLecturesObject:(LectureManagedObject *)value;
- (void)addLectures:(NSSet<LectureManagedObject *> *)values;
- (void)removeLectures:(NSSet<LectureManagedObject *> *)values;

- (void)addRegistrationQuestionsObject:(RegistrationQuestionManagedObject *)value;
- (void)removeRegistrationQuestionsObject:(RegistrationQuestionManagedObject *)value;
- (void)addRegistrationQuestions:(NSSet<RegistrationQuestionManagedObject *> *)values;
- (void)removeRegistrationQuestions:(NSSet<RegistrationQuestionManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
