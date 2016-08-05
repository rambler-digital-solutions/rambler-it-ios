//
// TagServicePredicateBuilder.m
// LiveJournal
// 
// Created by Golovko Mikhail on 24/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagServicePredicateBuilder.h"
#import "TagObjectDescriptor.h"
#import "TagModelObject.h"
#import "LectureModelObject.h"

@interface TagServicePredicateBuilder ()

/**
 @author Golovko Mikhail
 
 Мап объектов к полям их айдишников
 */
@property (nonatomic, strong, readonly) NSDictionary *mapObjectId;

@end

@implementation TagServicePredicateBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        _mapObjectId = @{
                NSStringFromClass([LectureModelObject class]) : LectureModelObjectAttributes.lectureId
        };
    }

    return self;
}

- (NSPredicate *)buildExcludeTagsByNames:(NSArray *)tags {
    return [NSPredicate predicateWithFormat:@"NOT (%K IN %@)",
                                            TagModelObjectAttributes.name,
                                            tags];
}

- (NSPredicate *)buildGetObjectPredicateFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    NSString *objectName = objectDescriptor.objectName;
    NSString *idFieldName = self.mapObjectId[objectName];
    return [NSPredicate predicateWithFormat:@"%K == %@",
                                            idFieldName,
                                            objectDescriptor.idValue];
}

@end