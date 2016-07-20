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
#import "EventManagedObject.h"
#import "LectureManagedObject.h"
#import "SpeakerManagedObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"
#import "LecturePlainObject.h"
#import "PrototypeMapper.h"
#import "EventTypeDeterminator.h"

@implementation ReportsSearchInteractor

#pragma mark - ReportListInteractorInput

- (NSArray *)obtainFoundObjectListWithSearchText:(NSString *)text {
    
    NSMutableArray *foundObjects = [NSMutableArray new];
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",text];
    
    id managedObjectEvents = [self.eventService obtainEventWithPredicate:predicate];
    NSArray *events = [self getPlainEventsFromManagedObjects:managedObjectEvents];
    [foundObjects addObjectsFromArray:events];
    
    id managedObjectSpeakers = [self.speakerService obtainSpeakerWithPredicate:predicate];
    NSArray *speakers = [self getPlainSpeakersFromManagedObjects:managedObjectSpeakers];
    [foundObjects addObjectsFromArray:speakers];
    
    id managedObjectLectures = [self.lectureService obtainLectureWithPredicate:predicate];
    NSArray *lectures = [self getPlainLecturesFromManagedObjects:managedObjectLectures];
    [foundObjects addObjectsFromArray:lectures];
    
    return foundObjects;
}

//
//#pragma mark - Private methods
//

- (NSArray *)getPlainEventsFromManagedObjects:(NSArray *)managedObjectEvents {
    NSMutableArray *eventPlainObjects = [NSMutableArray array];
    for (EventManagedObject *managedObjectEvent in managedObjectEvents) {
        EventPlainObject *eventPlainObject = [EventPlainObject new];
        
        [self.eventPrototypeMapper fillObject:eventPlainObject withObject:managedObjectEvent];
        
        [eventPlainObjects addObject:eventPlainObject];
    }
    return eventPlainObjects;
}

- (NSArray *)getPlainSpeakersFromManagedObjects:(NSArray *)managedObjectSpeakers {
    NSMutableArray *speakersPlainObjects = [NSMutableArray array];
    for (SpeakerManagedObject *managedObjectSpeaker in managedObjectSpeakers) {
        SpeakerPlainObject *speakerPlainObject = [SpeakerPlainObject new];
        
        [self.speakerPrototypeMapper fillObject:speakerPlainObject withObject:managedObjectSpeaker];
        
        [speakersPlainObjects addObject:speakerPlainObject];
    }
    return speakersPlainObjects;
}

- (NSArray *)getPlainLecturesFromManagedObjects:(NSArray *)managedObjectLectures {
    NSMutableArray *lecturePlainObjects = [NSMutableArray array];
    for (LectureManagedObject *managedObjectLecture in managedObjectLectures) {
        LecturePlainObject *lecturePlainObject = [LecturePlainObject new];
        
        [self.lecturePrototypeMapper fillObject:lecturePlainObject withObject:managedObjectLecture];
        
        [lecturePlainObjects addObject:lecturePlainObject];
    }
    return lecturePlainObjects;
}

@end
