//
//  _SpeakerPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_SpeakerPlainObject.h"
#import "SpeakerPlainObject.h"

@implementation _SpeakerPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.biography forKey:@"biography"];
    [aCoder encodeObject:self.company forKey:@"company"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.job forKey:@"job"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.speakerId forKey:@"speakerId"];
    [aCoder encodeObject:self.lectures forKey:@"lectures"];
    [aCoder encodeObject:self.socialNetworkAccounts forKey:@"socialNetworkAccounts"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _biography = [[aDecoder decodeObjectForKey:@"biography"] copy];
        _company = [[aDecoder decodeObjectForKey:@"company"] copy];
        _imageUrl = [[aDecoder decodeObjectForKey:@"imageUrl"] copy];
        _job = [[aDecoder decodeObjectForKey:@"job"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _speakerId = [[aDecoder decodeObjectForKey:@"speakerId"] copy];
        _lectures = [[aDecoder decodeObjectForKey:@"lectures"] copy];
        _socialNetworkAccounts = [[aDecoder decodeObjectForKey:@"socialNetworkAccounts"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    SpeakerPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.biography = self.biography;
    replica.company = self.company;
    replica.imageUrl = self.imageUrl;
    replica.job = self.job;
    replica.name = self.name;
    replica.speakerId = self.speakerId;

    replica.lectures = self.lectures;
    replica.socialNetworkAccounts = self.socialNetworkAccounts;

    return replica;
}

@end
