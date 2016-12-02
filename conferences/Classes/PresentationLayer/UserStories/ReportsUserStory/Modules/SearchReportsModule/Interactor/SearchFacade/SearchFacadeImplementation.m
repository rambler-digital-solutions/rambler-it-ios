//
//  SearchFacadeImplementation.m
//  Conferences
//
//  Created by s.sarkisyan on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SearchFacadeImplementation.h"
#import "EventService.h"
#import "LectureService.h"
#import "SpeakerService.h"
#import "ROSPonsomizer.h"

@implementation SearchFacadeImplementation

- (NSArray *)eventsForPredicates:(NSArray<NSPredicate *> *)predicates {
    id managedObjectEvents = [self.eventService obtainEventsWithPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
    NSArray *events = [self.ponsomizer convertObject:managedObjectEvents];
    
    return events;
}

- (NSArray *)speakersForPredicates:(NSArray<NSPredicate *> *)predicates {
    id managedObjectSpeakers = [self.speakerService obtainSpeakerWithPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
    NSArray *speakers = [self.ponsomizer convertObject:managedObjectSpeakers];
    
    return speakers;
}

- (NSArray *)lecturesForPredicates:(NSArray<NSPredicate *> *)predicates {
    id managedObjectLectures = [self.lectureService obtainLectureWithPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
    NSArray *lectures = [self.ponsomizer convertObject:managedObjectLectures];
    
    return lectures;
}

@end
