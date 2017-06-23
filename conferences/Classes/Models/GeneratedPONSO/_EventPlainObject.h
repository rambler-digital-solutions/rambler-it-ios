//
//  _Event.h
//
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import <Foundation/Foundation.h>

@class LecturePlainObject;
@class MetaEventPlainObject;
@class RegistrationQuestionPlainObject;
@class TechPlainObject;

@interface _EventPlainObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readwrite) NSDate *endDate;
@property (nonatomic, copy, readwrite) NSString *eventDescription;
@property (nonatomic, copy, readwrite) NSString *eventId;
@property (nonatomic, copy, readwrite) NSString *eventSubtitle;
@property (nonatomic, copy, readwrite) NSNumber *eventType;
@property (nonatomic, copy, readwrite) NSString *imageUrl;
@property (nonatomic, copy, readwrite) NSDate *lastVisitDate;
@property (nonatomic, copy, readwrite) NSString *liveStreamLink;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSDate *startDate;
@property (nonatomic, copy, readwrite) NSString *timePadID;
@property (nonatomic, copy, readwrite) NSString *twitterTag;

@property (nonatomic, copy, readwrite) NSSet<LecturePlainObject *> *lectures;

@property (nonatomic, copy, readwrite) MetaEventPlainObject *metaEvent;

@property (nonatomic, copy, readwrite) NSSet<RegistrationQuestionPlainObject *> *registrationQuestions;

@property (nonatomic, copy, readwrite) TechPlainObject *tech;

@end
