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

#import "PastEventCellObjectBuilder.h"

#import "EventInfoTableViewCellObject.h"
#import "VideoRecordTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "DateFormatter.h"

@implementation PastEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event
                      pastEvents:(NSArray *)pastEvents {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    NSString *formattedDate = [self.dateFormatter obtainDateWithDayMonthYearTimeFormat:event.startDate];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithEvent:event andDate:formattedDate];
    [cellObjects addObject:eventInfoCellObject];
    
    //Adding current event lectures section
    NSArray *lectureCellObjects = [self cellObjectsForLectureSectionWithEvent:event];
    [cellObjects addObjectsFromArray:lectureCellObjects];
    
    //Adding previous events section
    NSArray *pastEventCellObjects = [self cellObjectsForPastEventsSectionWithCurrentEvent:event
                                                                               pastEvents:pastEvents];
    [cellObjects addObjectsFromArray:pastEventCellObjects];
    
    //Adding previous lectures section
    NSArray *pastLectureCellObjects = [self cellObjectsForPastLecturesSectionWithCurrentEvent:event
                                                                                   pastEvents:pastEvents];
    [cellObjects addObjectsFromArray:pastLectureCellObjects];

    return cellObjects;
}

@end
