//
//  Event+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 10/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSString *eventDescription;
@property (nullable, nonatomic, retain) NSString *liveStreamLink;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *objectId;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSString *timePadID;
@property (nullable, nonatomic, retain) NSString *twitterLink;
@property (nullable, nonatomic, retain) NSSet<Lecture *> *lectures;
@property (nullable, nonatomic, retain) NSSet<RegistrationQuestion *> *registrationQuestions;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(Lecture *)value;
- (void)removeLecturesObject:(Lecture *)value;
- (void)addLectures:(NSSet<Lecture *> *)values;
- (void)removeLectures:(NSSet<Lecture *> *)values;

- (void)addRegistrationQuestionsObject:(RegistrationQuestion *)value;
- (void)removeRegistrationQuestionsObject:(RegistrationQuestion *)value;
- (void)addRegistrationQuestions:(NSSet<RegistrationQuestion *> *)values;
- (void)removeRegistrationQuestions:(NSSet<RegistrationQuestion *> *)values;

@end

NS_ASSUME_NONNULL_END
