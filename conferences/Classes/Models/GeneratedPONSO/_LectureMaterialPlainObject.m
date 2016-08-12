//
//  _LectureMaterialPlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_LectureMaterialPlainObject.h"
#import "LectureMaterialPlainObject.h"

@implementation _LectureMaterialPlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.lectureMaterialId forKey:@"lectureMaterialId"];
    [aCoder encodeObject:self.link forKey:@"link"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.lecture forKey:@"lecture"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _lectureMaterialId = [[aDecoder decodeObjectForKey:@"lectureMaterialId"] copy];
        _link = [[aDecoder decodeObjectForKey:@"link"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _type = [[aDecoder decodeObjectForKey:@"type"] copy];
        _lecture = [[aDecoder decodeObjectForKey:@"lecture"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    LectureMaterialPlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.lectureMaterialId = self.lectureMaterialId;
    replica.link = self.link;
    replica.name = self.name;
    replica.type = self.type;

    replica.lecture = self.lecture;

    return replica;
}

@end
