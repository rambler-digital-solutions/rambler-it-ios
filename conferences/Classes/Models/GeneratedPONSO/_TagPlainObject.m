//
//  _TagPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_TagPlainObject.h"
#import "TagPlainObject.h"

@implementation _TagPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.slug forKey:@"slug"];
    [aCoder encodeObject:self.tagId forKey:@"tagId"];
    [aCoder encodeObject:self.lectures forKey:@"lectures"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _slug = [[aDecoder decodeObjectForKey:@"slug"] copy];
        _tagId = [[aDecoder decodeObjectForKey:@"tagId"] copy];
        _lectures = [[aDecoder decodeObjectForKey:@"lectures"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    TagPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.name = self.name;
    replica.slug = self.slug;
    replica.tagId = self.tagId;

    replica.lectures = self.lectures;

    return replica;
}

@end
