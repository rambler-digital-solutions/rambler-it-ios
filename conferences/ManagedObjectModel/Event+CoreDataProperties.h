//
//  Event+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *eventDescription;
@property (nullable, nonatomic, retain) NSString *timePadID;
@property (nullable, nonatomic, retain) NSString *liveStreamLink;
@property (nullable, nonatomic, retain) NSString *twitterLink;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSSet<Talk *> *talks;
@property (nullable, nonatomic, retain) NSSet<RegistrationQuestion *> *registrationQuestions;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addTalksObject:(Talk *)value;
- (void)removeTalksObject:(Talk *)value;
- (void)addTalks:(NSSet<Talk *> *)values;
- (void)removeTalks:(NSSet<Talk *> *)values;

- (void)addRegistrationQuestionsObject:(RegistrationQuestion *)value;
- (void)removeRegistrationQuestionsObject:(RegistrationQuestion *)value;
- (void)addRegistrationQuestions:(NSSet<RegistrationQuestion *> *)values;
- (void)removeRegistrationQuestions:(NSSet<RegistrationQuestion *> *)values;

@end

NS_ASSUME_NONNULL_END
