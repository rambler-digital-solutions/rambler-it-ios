//
//  _SocialNetworkAccountPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_SocialNetworkAccountPlainObject.h"
#import "SocialNetworkAccountPlainObject.h"

@implementation _SocialNetworkAccountPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.profileLink forKey:@"profileLink"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.speaker forKey:@"speaker"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _profileLink = [[aDecoder decodeObjectForKey:@"profileLink"] copy];
        _type = [[aDecoder decodeObjectForKey:@"type"] copy];
        _speaker = [[aDecoder decodeObjectForKey:@"speaker"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    SocialNetworkAccountPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.profileLink = self.profileLink;
    replica.type = self.type;

    replica.speaker = self.speaker;

    return replica;
}

@end
