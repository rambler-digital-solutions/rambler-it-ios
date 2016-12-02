//
//  PredicateConfiguratorImplementation.m
//  Conferences
//
//  Created by s.sarkisyan on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "PredicateConfiguratorImplementation.h"

#import "EventModelObject.h"
#import "LectureModelObject.h"
#import "SpeakerModelObject.h"
#import "TagModelObject.h"

static NSString *const kEventsNameAndLecturesTagContainsQuery = @"%K CONTAINS[c] %@ OR SUBQUERY(%K, $lecture, SUBQUERY($lecture.%K, $tag, $tag.%K CONTAINS[c] %@).@count > 0).@count > 0";
static NSString *const kDefaultContainsQuery = @"%K CONTAINS[c] %@";
static NSString *const kLecturesNameTagsAndSpeakerNameContainsQuery = @"%K CONTAINS[c] %@ OR SUBQUERY(%K, $tag, $tag.%K CONTAINS[c] %@).@count > 0 OR %K.%K CONTAINS[c] %@";

@implementation PredicateConfiguratorImplementation

- (NSArray<NSPredicate *> *)configureEventsPredicatesForSearchText:(NSString *)searchText {
    NSString *selectorEventName = EventModelObjectAttributes.name;
    NSString *selectorLectures = EventModelObjectRelationships.lectures;
    NSString *selectorTags = LectureModelObjectRelationships.tags;
    NSString *selectorTagName = TagModelObjectAttributes.name;
    
    NSArray *separatedTextArray = [searchText componentsSeparatedByString:@" "];
    
    NSMutableArray *eventsPredicatesArray = [NSMutableArray new];
    
    for (NSString *string in separatedTextArray) {
        if (string.length == 0) {
            continue;
        }
        
        NSPredicate *eventsPredicate = [NSPredicate predicateWithFormat:kEventsNameAndLecturesTagContainsQuery, selectorEventName, string, selectorLectures, selectorTags, selectorTagName, string];
        [eventsPredicatesArray addObject:eventsPredicate];
    }
    
    return [eventsPredicatesArray copy];
}

- (NSArray<NSPredicate *> *)configureSpeakersPredicatesForSearchText:(NSString *)searchText {
    NSString *selectorSpeakerName = SpeakerModelObjectAttributes.name;
    
    NSArray *separatedTextArray = [searchText componentsSeparatedByString:@" "];
    
    NSMutableArray *speakersPredicatesArray = [NSMutableArray new];
    
    for (NSString *string in separatedTextArray) {
        if (string.length == 0) {
            continue;
        }
        
        NSPredicate *speakersPredicate = [NSPredicate predicateWithFormat:kDefaultContainsQuery, selectorSpeakerName, string];
        [speakersPredicatesArray addObject:speakersPredicate];
    }
    
    return [speakersPredicatesArray copy];
}

- (NSArray<NSPredicate *> *)configureLecturesPredicatesForSearchText:(NSString *)searchText {
    NSString *selectorLectureName = LectureModelObjectAttributes.name;
    NSString *selectorTags = LectureModelObjectRelationships.tags;
    NSString *selectorTagName = TagModelObjectAttributes.name;
    NSString *selectorSpeakerName = SpeakerModelObjectAttributes.name;
    NSString *selectorLectureSpeaker = LectureModelObjectRelationships.speaker;
    
    NSArray *separatedTextArray = [searchText componentsSeparatedByString:@" "];
    
    NSMutableArray *lecturesPredicatesArray = [NSMutableArray new];
    
    for (NSString *string in separatedTextArray) {
        if (string.length == 0) {
            continue;
        }
        
        NSPredicate *lecturesPredicate = [NSPredicate predicateWithFormat:kLecturesNameTagsAndSpeakerNameContainsQuery, selectorLectureName, string, selectorTags,selectorTagName, string, selectorLectureSpeaker, selectorSpeakerName, string];
        [lecturesPredicatesArray addObject:lecturesPredicate];
    }
    
    return [lecturesPredicatesArray copy];
}

@end
