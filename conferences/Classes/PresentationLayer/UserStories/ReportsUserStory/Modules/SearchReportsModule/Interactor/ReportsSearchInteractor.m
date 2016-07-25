//
//  ReportsSearchInteractor.m
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchInteractor.h"

#import "SpeakerService.h"
#import "LectureService.h"
#import "EventService.h"
#import "EventModelObject.h"
#import "LectureModelObject.h"
#import "SpeakerModelObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"
#import "LecturePlainObject.h"
#import "EventTypeDeterminator.h"
#import "ROSPonsomizer.h"

@implementation ReportsSearchInteractor

#pragma mark - ReportListInteractorInput

- (NSArray *)obtainFoundObjectListWithSearchText:(NSString *)text {
    
    NSMutableArray *foundObjects = [NSMutableArray new];
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",text];
    
    id managedObjectEvents = [self.eventService obtainEventWithPredicate:predicate];
    NSArray *events = [self.ponsomizer convertObject:managedObjectEvents];
    [foundObjects addObjectsFromArray:events];
    
    id managedObjectSpeakers = [self.speakerService obtainSpeakerWithPredicate:predicate];
    NSArray *speakers = [self.ponsomizer convertObject:managedObjectSpeakers];
    [foundObjects addObjectsFromArray:speakers];
    
    id managedObjectLectures = [self.lectureService obtainLectureWithPredicate:predicate];
    NSArray *lectures = [self.ponsomizer convertObject:managedObjectLectures];
    [foundObjects addObjectsFromArray:lectures];
    
    return foundObjects;
}

@end
