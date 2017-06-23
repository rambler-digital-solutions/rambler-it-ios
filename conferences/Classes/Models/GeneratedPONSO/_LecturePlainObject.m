//
//  _LecturePlainObject.m
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import "_LecturePlainObject.h"
#import "LecturePlainObject.h"

@implementation _LecturePlainObject

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.favourite forKey:@"favourite"];
    [aCoder encodeObject:self.lectureDescription forKey:@"lectureDescription"];
    [aCoder encodeObject:self.lectureId forKey:@"lectureId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.event forKey:@"event"];
    [aCoder encodeObject:self.lectureMaterials forKey:@"lectureMaterials"];
    [aCoder encodeObject:self.speaker forKey:@"speaker"];
    [aCoder encodeObject:self.tags forKey:@"tags"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {

        _favourite = [[aDecoder decodeObjectForKey:@"favourite"] copy];
        _lectureDescription = [[aDecoder decodeObjectForKey:@"lectureDescription"] copy];
        _lectureId = [[aDecoder decodeObjectForKey:@"lectureId"] copy];
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _event = [[aDecoder decodeObjectForKey:@"event"] copy];
        _lectureMaterials = [[aDecoder decodeObjectForKey:@"lectureMaterials"] copy];
        _speaker = [[aDecoder decodeObjectForKey:@"speaker"] copy];
        _tags = [[aDecoder decodeObjectForKey:@"tags"] copy];
    }

    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    LecturePlainObject *replica = [[[self class] allocWithZone:zone] init];

    replica.favourite = self.favourite;
    replica.lectureDescription = self.lectureDescription;
    replica.lectureId = self.lectureId;
    replica.name = self.name;

    replica.event = self.event;
    replica.lectureMaterials = self.lectureMaterials;
    replica.speaker = self.speaker;
    replica.tags = self.tags;

    return replica;
}

@end
