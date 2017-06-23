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

#import <Foundation/Foundation.h>

@class EventPlainObject;
@class DateFormatter;
@class TechPlainObject;
@class EventPlainObject;
@class LectureInfoTableViewCellObjectMapper;

@interface EventCellObjectBuilderBase : NSObject

@property (nonatomic, strong) DateFormatter *dateFormatter;
@property (nonatomic, strong) LectureInfoTableViewCellObjectMapper *lectureInfoCellObjectMapper;

/**
 @author Vasyura Anastasiya
 
 Build cell objects for event detailed tableview model
 
 @param event      current event
 @param pastEvents past events
 
 @return CellObjects
 */
- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event
                      pastEvents:(NSArray *)pastEvents;

/**
 @author Vasyura Anastasiya
 
 Build cellObjects for current event lectures section
 
 @param event current event
 
 @return Cellobjects
 */
- (NSArray *)cellObjectsForLectureSectionWithEvent:(EventPlainObject *)event;

/**
 @author Vasyura Anastasiya
 
 Build cellObjects for past events section
 
 @param event      currentEvent
 @param pastEvents past events
 
 @return CellObjects
 */
- (NSArray *)cellObjectsForPastEventsSectionWithCurrentEvent:(EventPlainObject *)event
                                                  pastEvents:(NSArray *)pastEvents;

/**
 @author Vasyura Anastasiya
 
 Build cellObjects for past lectures section
 
 @param event      current event
 @param pastEvents past events
 
 @return CellObjects
 */
- (NSArray *)cellObjectsForPastLecturesSectionWithCurrentEvent:(EventPlainObject *)event
                                                    pastEvents:(NSArray *)pastEvents;
@end
