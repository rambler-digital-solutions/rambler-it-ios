//
//  _EventPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_EventPlainObject.h"
#import "EventPlainObject.h"

@implementation _EventPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.endDate forKey:@"endDate"];
    [aCoder encodeObject:self.eventDescription forKey:@"eventDescription"];
    [aCoder encodeObject:self.eventId forKey:@"eventId"];
    [aCoder encodeObject:self.eventSubtitle forKey:@"eventSubtitle"];
    [aCoder encodeObject:self.eventType forKey:@"eventType"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.liveStreamLink forKey:@"liveStreamLink"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.timePadID forKey:@"timePadID"];
    [aCoder encodeObject:self.twitterTag forKey:@"twitterTag"];
    [aCoder encodeObject:self.lectures forKey:@"lectures"];
    [aCoder encodeObject:self.metaEvent forKey:@"metaEvent"];
    [aCoder encodeObject:self.registrationQuestions forKey:@"registrationQuestions"];
    [aCoder encodeObject:self.tags forKey:@"tags"];
    [aCoder encodeObject:self.tech forKey:@"tech"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _endDate = [[aDecoder decodeObjectForKey:@"endDate"] copy];
        _eventDescription = [[aDecoder decodeObjectForKey:@"eventDescription"] copy];
        _eventId = [[aDecoder decodeObjectForKey:@"eventId"] copy];
        _eventSubtitle = [[aDecoder decodeObjectForKey:@"eventSubtitle"] copy];
        _eventType = [[aDecoder decodeObjectForKey:@"eventType"] copy];
        _imageUrl = [[aDecoder decodeObjectForKey:@"imageUrl"] copy];
        _liveStreamLink = [[aDecoder decodeObjectForKey:@"liveStreamLink"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _startDate = [[aDecoder decodeObjectForKey:@"startDate"] copy];
        _timePadID = [[aDecoder decodeObjectForKey:@"timePadID"] copy];
        _twitterTag = [[aDecoder decodeObjectForKey:@"twitterTag"] copy];
        _lectures = [[aDecoder decodeObjectForKey:@"lectures"] copy];
        _metaEvent = [[aDecoder decodeObjectForKey:@"metaEvent"] copy];
        _registrationQuestions = [[aDecoder decodeObjectForKey:@"registrationQuestions"] copy];
        _tags = [[aDecoder decodeObjectForKey:@"tags"] copy];
        _tech = [[aDecoder decodeObjectForKey:@"tech"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    EventPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.endDate = self.endDate;
    replica.eventDescription = self.eventDescription;
    replica.eventId = self.eventId;
    replica.eventSubtitle = self.eventSubtitle;
    replica.eventType = self.eventType;
    replica.imageUrl = self.imageUrl;
    replica.liveStreamLink = self.liveStreamLink;
    replica.name = self.name;
    replica.startDate = self.startDate;
    replica.timePadID = self.timePadID;
    replica.twitterTag = self.twitterTag;

    replica.lectures = self.lectures;
    replica.metaEvent = self.metaEvent;
    replica.registrationQuestions = self.registrationQuestions;
    replica.tags = self.tags;
    replica.tech = self.tech;

    return replica;
}

@end
