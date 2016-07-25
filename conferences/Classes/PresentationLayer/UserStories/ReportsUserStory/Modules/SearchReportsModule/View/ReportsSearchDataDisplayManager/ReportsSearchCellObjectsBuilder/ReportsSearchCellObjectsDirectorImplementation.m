//
//  ReportsSearchCellObjectsDirector.m
//  Conferences
//
//  Created by k.zinovyev on 25.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchCellObjectsDirectorImplementation.h"
#import "ReportsSearchCellObjectsBuilder.h"
#import "LecturePlainObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"

@implementation ReportsSearchCellObjectsDirectorImplementation

- (instancetype)initWithBuilder:(id<ReportsSearchCellObjectsBuilder>)builder {
    self = [super init];
    if (self) {
        _builder = builder;
    }
    return self;
}

- (NSArray *)generateCellObjectsFromPlainObjects:(NSArray *)plainObjects selectedText:(NSString *)selectedText {
    
    if (!plainObjects) {
        return nil;
    }
    
    NSDictionary *sectionsNamesByClassName = [self sectionsNamesForPlainClass];
    NSDictionary *selectorsBuilderByClassName = [self selectorsBuilderForPlainClass];
    NSArray *namesClass = [[self selectorsBuilderForPlainClass] allKeys];
    NSMutableArray *resultCellObjects = [NSMutableArray new];
    
    for (NSString *nameClass in namesClass) {
        
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"className == %@", nameClass];
        NSArray *sectionPlainObjects = [plainObjects filteredArrayUsingPredicate:predicate];
        
        if ([sectionPlainObjects count] == 0) {
            continue;
        }
        
        NSString *sectionName = sectionsNamesByClassName[nameClass];
        [resultCellObjects addObject:sectionName];
        
        id cellObject = nil;
        
        for (id plainObject in sectionPlainObjects) {
            SEL selector = NSSelectorFromString(selectorsBuilderByClassName[nameClass]);
            if ([self.builder respondsToSelector:selector]) {
                 cellObject = [self.builder performSelector:selector withObject:plainObject withObject:selectedText];
            }
            [resultCellObjects addObject:cellObject];
        }
        
    }
    
    return [resultCellObjects copy];
}


- (NSDictionary *)selectorsBuilderForPlainClass {
    return @{
             NSStringFromClass([LecturePlainObject class]) : NSStringFromSelector(@selector(lectureCellObjectFromPlainObject:selectedText:)),
             NSStringFromClass([EventPlainObject class])   : NSStringFromSelector(@selector(eventCellObjectFromPlainObject:selectedText:)),
             NSStringFromClass([SpeakerPlainObject class]) : NSStringFromSelector(@selector(speakerCellObjectFromPlainObject:selectedText:)),
             };
}

- (NSDictionary *)sectionsNamesForPlainClass {
    return @{
             NSStringFromClass([LecturePlainObject class]) : @"Доклады",
             NSStringFromClass([EventPlainObject class])   : @"Конференции",
             NSStringFromClass([SpeakerPlainObject class]) : @"Докладчики"
             };
}

@end
