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

@class ReportEventTableViewCellObject;
@class ReportLectureTableViewCellObject;
@class ReportSpeakerTableViewCellObject;

@class LecturePlainObject;
@class EventPlainObject;
@class SpeakerPlainObject;

@protocol ReportsSearchCellObjectsBuilder <NSObject>

/**
 @author Zinovyev Konstantin
 
 Method generates event cell object from event plain object
 
 @param event        plain object
 @param selectedText text, that need select by custom color
 
 @return event cell object
 */
- (ReportEventTableViewCellObject *)eventCellObjectFromPlainObject:(EventPlainObject *)event
                                                      selectedText:(NSString *)selectedText;

/**
 @author Zinovyev Konstantin
 
 Method generates lecture cell object from event plain object
 
 @param event        plain object
 @param selectedText text, that need select by custom color
 
 @return lecture cell object
 */
- (ReportLectureTableViewCellObject *)lectureCellObjectFromPlainObject:(LecturePlainObject *)lecture
                                                          selectedText:(NSString *)selectedText;

/**
 @author Zinovyev Konstantin
 
 Method generates speaker cell object from event plain object
 
 @param event        plain object
 @param selectedText text, that need select by custom color
 
 @return speaker cell object
 */
- (ReportSpeakerTableViewCellObject *)speakerCellObjectFromPlainObject:(SpeakerPlainObject *)speaker
                                                          selectedText:(NSString *)selectedText;

@end

