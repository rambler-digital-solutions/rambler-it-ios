//
//  _RegistrationQuestionPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_RegistrationQuestionPlainObject.h"
#import "RegistrationQuestionPlainObject.h"

@implementation _RegistrationQuestionPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.orderID forKey:@"orderID"];
    [aCoder encodeObject:self.event forKey:@"event"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _orderID = [[aDecoder decodeObjectForKey:@"orderID"] copy];
        _event = [[aDecoder decodeObjectForKey:@"event"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    RegistrationQuestionPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.name = self.name;
    replica.orderID = self.orderID;

    replica.event = self.event;

    return replica;
}

@end
