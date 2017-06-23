//
//  TagPlainObject.m
//
//

#import "TagPlainObject.h"

@implementation TagPlainObject

- (BOOL)isEqual:(TagPlainObject *)object {
    if ([object isKindOfClass:[self class]]) {
        return (!self.tagId && ![object tagId]) || [self.tagId isEqual:[object tagId]];
    }
    return NO;
}

- (NSUInteger)hash {
    return [[self tagId] hash];
}

@end
