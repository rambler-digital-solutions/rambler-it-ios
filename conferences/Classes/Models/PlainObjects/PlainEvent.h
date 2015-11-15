//
//  PlainEvent.h
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EventType.h"

@interface PlainEvent : NSObject

// пока окончательно не сформирована модель данных - все проперти readwrite
// добавить в модель subtitle;
@property (nonatomic, strong, readwrite) NSString *eventDescription;
@property (nonatomic, strong, readwrite) NSString *liveStreamLink;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *objectId;
@property (nonatomic, strong, readwrite) NSDate *startDate;
@property (nonatomic, strong, readwrite) NSDate *endDate;
@property (nonatomic, strong, readwrite) NSString *timePadID;
@property (nonatomic, strong, readwrite) NSString *twitterLink;
@property (nonatomic, strong, readwrite) NSArray *lectures;
@property (nonatomic, strong, readwrite) NSArray *registrationQuestions;
@property (nonatomic, strong, readwrite) NSString *tags;
@property (nonatomic, strong, readwrite) UIColor *backgroundColor;
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, strong, readwrite) NSURL *imageUrl;
@property (nonatomic, strong, readwrite) NSString *eventSubtitle;
@property (nonatomic, assign, readwrite) EventType eventType;

@end
