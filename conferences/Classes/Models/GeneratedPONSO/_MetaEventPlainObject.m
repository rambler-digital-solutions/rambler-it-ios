//
//  _MetaEventPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_MetaEventPlainObject.h"
#import "MetaEventPlainObject.h"

@implementation _MetaEventPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.imageUrlPath forKey:@"imageUrlPath"];
    [aCoder encodeObject:self.metaEventDescription forKey:@"metaEventDescription"];
    [aCoder encodeObject:self.metaEventId forKey:@"metaEventId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.websiteUrlPath forKey:@"websiteUrlPath"];
    [aCoder encodeObject:self.events forKey:@"events"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _imageUrlPath = [[aDecoder decodeObjectForKey:@"imageUrlPath"] copy];
        _metaEventDescription = [[aDecoder decodeObjectForKey:@"metaEventDescription"] copy];
        _metaEventId = [[aDecoder decodeObjectForKey:@"metaEventId"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _websiteUrlPath = [[aDecoder decodeObjectForKey:@"websiteUrlPath"] copy];
        _events = [[aDecoder decodeObjectForKey:@"events"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    MetaEventPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.imageUrlPath = self.imageUrlPath;
    replica.metaEventDescription = self.metaEventDescription;
    replica.metaEventId = self.metaEventId;
    replica.name = self.name;
    replica.websiteUrlPath = self.websiteUrlPath;

    replica.events = self.events;

    return replica;
}

@end
