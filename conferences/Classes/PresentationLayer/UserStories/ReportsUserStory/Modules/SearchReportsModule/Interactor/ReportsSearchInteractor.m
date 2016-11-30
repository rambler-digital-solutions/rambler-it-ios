// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ReportsSearchInteractor.h"

#import "SpeakerService.h"
#import "LectureService.h"
#import "EventService.h"
#import "EventModelObject.h"
#import "LectureModelObject.h"
#import "SpeakerModelObject.h"
#import "TagModelObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"
#import "LecturePlainObject.h"
#import "EventTypeDeterminator.h"
#import "ROSPonsomizer.h"

static NSString *const kEventsNameAndLecturesTagContainsQuery = @"%K CONTAINS[c] %@ OR SUBQUERY(%K, $lecture, SUBQUERY($lecture.%K, $tag, $tag.%K CONTAINS[c] %@).@count > 0).@count > 0";
static NSString *const kDefaultContainsQuery = @"%K CONTAINS[c] %@";
static NSString *const kLecturesNameTagsAndSpeakerNameContainsQuery = @"%K CONTAINS[c] %@ OR SUBQUERY(%K, $tag, $tag.%K CONTAINS[c] %@).@count > 0 OR %K.%K CONTAINS[c] %@";

@implementation ReportsSearchInteractor

#pragma mark - ReportListInteractorInput

- (NSArray *)obtainFoundObjectListWithSearchText:(NSString *)text {
    
    NSMutableArray *foundObjects = [NSMutableArray new];
    
    NSString *selectorEventName = EventModelObjectAttributes.name;
    NSString *selectorLectures = EventModelObjectRelationships.lectures;
    NSString *selectorTags = LectureModelObjectRelationships.tags;
    NSString *selectorTagName = TagModelObjectAttributes.name;
    NSString *selectorSpeakerName = SpeakerModelObjectAttributes.name;
    NSString *selectorLectureName = LectureModelObjectAttributes.name;
    NSString *selectorLectureSpeaker = LectureModelObjectRelationships.speaker;
    
    NSArray *separetedTextArray = [text componentsSeparatedByString:@" "];
    
    NSMutableArray *eventsPredicatesArray = [NSMutableArray new];
    NSMutableArray *speakersPredicatesArray = [NSMutableArray new];
    NSMutableArray *lecturesPredicatesArray = [NSMutableArray new];
    
    for (NSString *string in separetedTextArray) {
        if (string.length == 0) {
            continue;
        }
        
        NSPredicate *eventsPredicate = [NSPredicate predicateWithFormat:kEventsNameAndLecturesTagContainsQuery, selectorEventName, string, selectorLectures, selectorTags, selectorTagName, string];
        [eventsPredicatesArray addObject:eventsPredicate];
        
        NSPredicate *speakersPredicate = [NSPredicate predicateWithFormat:kDefaultContainsQuery, selectorSpeakerName, string];
        [speakersPredicatesArray addObject:speakersPredicate];
        
        NSPredicate *lecturesPredicate = [NSPredicate predicateWithFormat:kLecturesNameTagsAndSpeakerNameContainsQuery, selectorLectureName, string, selectorTags,selectorTagName, string, selectorLectureSpeaker, selectorSpeakerName, string];
        [lecturesPredicatesArray addObject:lecturesPredicate];
    }
    
    id managedObjectEvents = [self.eventService obtainEventsWithPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[eventsPredicatesArray copy]]];
    NSArray *events = [self.ponsomizer convertObject:managedObjectEvents];
    [foundObjects addObjectsFromArray:events];
    
    id managedObjectSpeakers = [self.speakerService obtainSpeakerWithPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[speakersPredicatesArray copy]]];
    NSArray *speakers = [self.ponsomizer convertObject:managedObjectSpeakers];
    [foundObjects addObjectsFromArray:speakers];
    
    id managedObjectLectures = [self.lectureService obtainLectureWithPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[lecturesPredicatesArray copy]]];
    NSArray *lectures = [self.ponsomizer convertObject:managedObjectLectures];
    [foundObjects addObjectsFromArray:lectures];
    
    return [foundObjects copy];
}

@end
