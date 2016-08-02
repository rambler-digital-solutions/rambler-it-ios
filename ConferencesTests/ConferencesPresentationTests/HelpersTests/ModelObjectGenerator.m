//
//  ModelObjectGenerator.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 29/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ModelObjectGenerator.h"
#import "LecturePlainObject.h"
#import "EventPlainObject.h"

@implementation ModelObjectGenerator

+ (NSArray *)generateEventObjects:(NSInteger)count {
    
    NSMutableArray *events = [NSMutableArray new];
    for (NSInteger index = 0; index < count; index++) {
        EventPlainObject *event = [EventPlainObject new];
        event.eventId = [NSString stringWithFormat:@"%d", index];
        
        NSArray *lectures = [self generateLectureObjects:3];
        event.lectures = [NSSet setWithArray:lectures];
        
        [events addObject:event];
    }
    
    return events;
}

+ (NSArray *)generateLectureObjects:(NSInteger)count {
    NSMutableArray *lectures = [NSMutableArray new];
    for (NSInteger index = 0; index < count; index++) {
        LecturePlainObject *lecture = [LecturePlainObject new];
        lecture.lectureId = [NSString stringWithFormat:@"%d", index];
        
        [lectures addObject:lecture];
    }
    
    return lectures;

}

@end
