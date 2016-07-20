//
//  LecturePrototypeMapper.m
//  Conferences
//
//  Created by k.zinovyev on 19.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LecturePrototypeMapper.h"

#import "LectureManagedObject.h"
#import "LecturePlainObject.h"
#import "EventManagedObject.h"

@implementation LecturePrototypeMapper

- (void)fillObject:(LecturePlainObject *)filledObject withObject:(LectureManagedObject *)object {
    filledObject.favourite = object.favourite;
    filledObject.name = object.name;
    filledObject.startDate = object.event.startDate;
    filledObject.lectureMaterials = [object.lectureMaterials allObjects];
    filledObject.lectureDescription = object.lectureDescription;
    filledObject.objectId = object.lectureId;
    filledObject.speakers = @[object.speaker];
}

@end
