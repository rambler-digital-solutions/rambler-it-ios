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
#import "PastVideoTranslationTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureShortInfoTableViewCellObject.h"
#import "SpeakerShortInfoTableViewCellObject.h"
#import "SpeakerShortInfoTableViewCellSize.h"
#import "PlainEvent.h"
#import "PlainLecture.h"
#import "DateFormatter.h"

@implementation PastEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    NSString *formattedDate = [self.dateFormatter obtainDateWithDayMonthTimeFormat:event.startDate];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithEvent:event andDate:formattedDate];
    [cellObjects addObject:eventInfoCellObject];
    
    PastVideoTranslationTableViewCellObject *videoCellObject = [PastVideoTranslationTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:videoCellObject];
    
    EventDescriptionTableViewCellObject *eventDescriptionCellObject = [EventDescriptionTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:eventDescriptionCellObject];
    
    for (PlainLecture *lecture in event.lectures) {
        PlainSpeaker *speaker = [lecture.speakers firstObject];
        SpeakerShortInfoTableViewCellObject *speakerCellObject = [SpeakerShortInfoTableViewCellObject objectWithSpeaker:speaker cellSize:SpeakerShortInfoTableViewCellDefaultSize];
        [cellObjects addObject:speakerCellObject];
        
        LectureShortInfoTableViewCellObject *lectionCellobject = [LectureShortInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectionCellobject];
    }
    
    return cellObjects;
}

@end
