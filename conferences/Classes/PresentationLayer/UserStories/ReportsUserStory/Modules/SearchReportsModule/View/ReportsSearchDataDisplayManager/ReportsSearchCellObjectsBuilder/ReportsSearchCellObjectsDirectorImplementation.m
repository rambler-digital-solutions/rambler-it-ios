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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                 cellObject = [self.builder performSelector:selector withObject:plainObject withObject:selectedText];
#pragma clang diagnostic pop
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
