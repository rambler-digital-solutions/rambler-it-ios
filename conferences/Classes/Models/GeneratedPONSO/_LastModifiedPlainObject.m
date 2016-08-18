//
//  _LastModifiedPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_LastModifiedPlainObject.h"
#import "LastModifiedPlainObject.h"

@implementation _LastModifiedPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.lastModifiedDate forKey:@"lastModifiedDate"];
    [aCoder encodeObject:self.lastModifiedId forKey:@"lastModifiedId"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _lastModifiedDate = [[aDecoder decodeObjectForKey:@"lastModifiedDate"] copy];
        _lastModifiedId = [[aDecoder decodeObjectForKey:@"lastModifiedId"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    LastModifiedPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.lastModifiedDate = self.lastModifiedDate;
    replica.lastModifiedId = self.lastModifiedId;
    replica.name = self.name;

    return replica;
}

@end
