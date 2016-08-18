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

#import "ReportsSearchCellObjectsDirectorImplementation.h"
#import "ReportsSearchCellObjectsBuilder.h"
#import "LecturePlainObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"
#import "UIColor+ConferencesPalette.h"
#import "LocalizedStrings.h"
#import "ReportSearchSectionObject.h"

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
    NSArray *sectionObjects = [self generateSectionsObject];
    NSMutableArray *resultCellObjects = [NSMutableArray new];
    
    for (ReportSearchSectionObject *sectionObject in sectionObjects) {
        
        NSArray *sectionPlainObjects = [self getObjectsByNameClass:sectionObject.nameObjectClassInSection
                                                       fromObjects:plainObjects];
        
        if ([sectionPlainObjects count] == 0) {
            continue;
        }
        
        ReportSearchSectionTitleCellObject *sectionCell = [self generateSectionCellForSecionObject:sectionObject];
        NSArray *cellObjects = [self generateCellObjectsForNameClass:sectionObject.nameObjectClassInSection
                                                    fromPlainObjects:sectionPlainObjects
                                                        selectedText:selectedText];
        [resultCellObjects addObject:sectionCell];
        [resultCellObjects addObjectsFromArray:cellObjects];
    }
    
    return [resultCellObjects copy];
}

#pragma mark - private methods

- (NSArray *)getObjectsByNameClass:(NSString *)nameClass fromObjects:(NSArray *)objects {
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"className == %@", nameClass];
    NSArray *sectionPlainObjects = [objects filteredArrayUsingPredicate:predicate];
    return sectionPlainObjects;
}

- (ReportSearchSectionTitleCellObject *)generateSectionCellForSecionObject:(ReportSearchSectionObject *)sectionObject {
    ReportSearchSectionTitleCellObject *sectionCell = [self.builder sectionCellObjectWithTitle:sectionObject.titleSection
                                                                               backgroundColor:sectionObject.backgroundColorSection];
    return sectionCell;
}

- (NSArray *)generateCellObjectsForNameClass:(NSString *)nameClass
                            fromPlainObjects:(NSArray *)plainObjects
                                selectedText:(NSString *)selectedText {
    NSDictionary *selectorsBuilderByClassName = [self selectorsBuilderForPlainClass];
    NSMutableArray *cellObjects = [NSMutableArray new];
    id cellObject = nil;
    for (id plainObject in plainObjects) {
        SEL selector = NSSelectorFromString(selectorsBuilderByClassName[nameClass]);
        if ([self.builder respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            cellObject = [self.builder performSelector:selector
                                            withObject:plainObject
                                            withObject:selectedText];
#pragma clang diagnostic pop
        }
        [cellObjects addObject:cellObject];
    }
    return cellObjects;
}

- (NSArray *)generateSectionsObject {
    ReportSearchSectionObject *eventSection = [ReportSearchSectionObject objectSectionWithTitle:RCLocalize(kReportSearchEventSectionTitle)
                                                                                  nameObjectClass:NSStringFromClass([EventPlainObject class])
                                                                                backgroundColor:[UIColor rcf_lightGrayBackgroundColor]];
    
    ReportSearchSectionObject *lectureSection = [ReportSearchSectionObject objectSectionWithTitle:RCLocalize(kReportSearchLectureSectionTitle)
                                                                                    nameObjectClass:NSStringFromClass([LecturePlainObject class])
                                                                                  backgroundColor:[UIColor whiteColor]];
    
    ReportSearchSectionObject *speakerSection = [ReportSearchSectionObject objectSectionWithTitle:RCLocalize(kReportSearchSpeakerSectionTitle)
                                                                                    nameObjectClass:NSStringFromClass([SpeakerPlainObject class])
                                                                                  backgroundColor:[UIColor whiteColor]];
    return @[
             eventSection,
             lectureSection,
             speakerSection
             ];
}

- (NSDictionary *)selectorsBuilderForPlainClass {
    return @{
             NSStringFromClass([EventPlainObject class])   : NSStringFromSelector(@selector(eventCellObjectFromPlainObject:selectedText:)),
             NSStringFromClass([LecturePlainObject class]) : NSStringFromSelector(@selector(lectureCellObjectFromPlainObject:selectedText:)),
             NSStringFromClass([SpeakerPlainObject class]) : NSStringFromSelector(@selector(speakerCellObjectFromPlainObject:selectedText:)),
             };
}



@end
