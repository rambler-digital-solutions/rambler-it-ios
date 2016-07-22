//
//  _TechPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_TechPlainObject.h"
#import "TechPlainObject.h"

@implementation _TechPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.color forKey:@"color"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.techId forKey:@"techId"];
    [aCoder encodeObject:self.events forKey:@"events"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _color = [[aDecoder decodeObjectForKey:@"color"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _techId = [[aDecoder decodeObjectForKey:@"techId"] copy];
        _events = [[aDecoder decodeObjectForKey:@"events"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    TechPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.color = self.color;
    replica.name = self.name;
    replica.techId = self.techId;

    replica.events = self.events;

    return replica;
}

@end
