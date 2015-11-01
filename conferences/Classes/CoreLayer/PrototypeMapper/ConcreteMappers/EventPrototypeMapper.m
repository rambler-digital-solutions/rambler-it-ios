//
//  EventPrototypeMapper.m
//  Conferences
//
//  Created by Karpushin Artem on 31/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventPrototypeMapper.h"

#import "Event.h"
#import "PlainEvent.h"

#import "UIColor+Hex.h"

@implementation EventPrototypeMapper

// TODO: добавить маппинг лекций после того как будет создан класс PlainLecture, так же PlainRegistratinQuestions
- (void)fillObject:(PlainEvent *)filledObject withObject:(Event *)object {
    filledObject.eventDescription = object.eventDescription;
    filledObject.liveStreamLink = object.liveStreamLink;
    filledObject.name = object.name;
    filledObject.objectId = object.objectId;
    filledObject.startDate = object.startDate;
    filledObject.endDate = object.endDate;
    filledObject.timePadID = object.timePadID;
    filledObject.twitterLink = object.twitterLink;
    filledObject.tags = object.tags;
    // починить категорию
    filledObject.backgroundColor = [UIColor colorFromHexString:object.backgroundColor];
    filledObject.imageUrl = [NSURL URLWithString:object.imageUrl];
}



@end
