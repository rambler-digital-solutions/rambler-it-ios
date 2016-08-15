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
#import "UIColor+ConferencesPallete.h"

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
    NSArray *namesClass = [self sectionsCellInCorrectOrder];
    NSMutableArray *resultCellObjects = [NSMutableArray new];
    
    for (NSString *nameClass in namesClass) {
        
        NSArray *sectionPlainObjects = [self getObjectsByNameClass:nameClass
                                                       fromObjects:plainObjects];
        
        if ([sectionPlainObjects count] == 0) {
            continue;
        }
        
        id sectionCell = [self generateSectionCellForNameClass:nameClass];
        NSArray *cellObjects = [self generateCellObjectsForNameClass:nameClass
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

- (id)generateSectionCellForNameClass:(NSString *)nameClass {
    NSDictionary *sectionsNamesByClassName = [self sectionsNamesForPlainClass];
    NSDictionary *colorSections = [self colorSectionsByNameClass];
    NSString *sectionName = sectionsNamesByClassName[nameClass];
    UIColor *sectionColor = colorSections[nameClass];
    id sectionCell = [self.builder sectionCellObjectWithTitle:sectionName
                                              backgroundColor:sectionColor];
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
- (NSArray *)sectionsCellInCorrectOrder {
    return @[
             NSStringFromClass([EventPlainObject class]),
             NSStringFromClass([LecturePlainObject class]),
             NSStringFromClass([SpeakerPlainObject class])
             ];
}

- (NSDictionary *)sectionsNamesForPlainClass {
    return @{
             NSStringFromClass([EventPlainObject class])   : @"События",
             NSStringFromClass([LecturePlainObject class]) : @"Выступления",
             NSStringFromClass([SpeakerPlainObject class]) : @"Докладчики"
             };
}

- (NSDictionary *)colorSectionsByNameClass {
    return @{
             NSStringFromClass([EventPlainObject class])   : [UIColor LJ_lightGrayBackgroundColor],
             NSStringFromClass([LecturePlainObject class]) : [UIColor whiteColor],
             NSStringFromClass([SpeakerPlainObject class]) : [UIColor whiteColor]
             };
}

- (NSDictionary *)selectorsBuilderForPlainClass {
    return @{
             NSStringFromClass([EventPlainObject class])   : NSStringFromSelector(@selector(eventCellObjectFromPlainObject:selectedText:)),
             NSStringFromClass([LecturePlainObject class]) : NSStringFromSelector(@selector(lectureCellObjectFromPlainObject:selectedText:)),
             NSStringFromClass([SpeakerPlainObject class]) : NSStringFromSelector(@selector(speakerCellObjectFromPlainObject:selectedText:)),
             };
}

@end
