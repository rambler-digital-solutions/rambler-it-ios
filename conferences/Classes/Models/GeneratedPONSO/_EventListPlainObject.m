//
//  _EventListPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_EventListPlainObject.h"
#import "EventListPlainObject.h"

@implementation _EventListPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.eventListId forKey:@"eventListId"];
    [aCoder encodeObject:self.lastModified forKey:@"lastModified"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _eventListId = [[aDecoder decodeObjectForKey:@"eventListId"] copy];
        _lastModified = [[aDecoder decodeObjectForKey:@"lastModified"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    EventListPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.eventListId = self.eventListId;
    replica.lastModified = self.lastModified;
    replica.name = self.name;

    return replica;
}

@end
