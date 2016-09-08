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

#import "ModelObjectGenerator.h"
#import "LecturePlainObject.h"
#import "EventPlainObject.h"

@implementation ModelObjectGenerator

+ (NSArray *)generateEventObjects:(NSInteger)count {
    
    NSMutableArray *events = [NSMutableArray new];
    for (NSInteger index = 0; index < count; index++) {
        EventPlainObject *event = [EventPlainObject new];
        event.eventId = [NSString stringWithFormat:@"%li", index];
        
        NSArray *lectures = [self generateLectureObjects:3];
        event.lectures = [NSSet setWithArray:lectures];
        
        [events addObject:event];
    }
    
    return events;
}

+ (NSArray *)generateLectureObjects:(NSInteger)count {
    NSMutableArray *lectures = [NSMutableArray new];
    for (NSInteger index = 0; index < count; index++) {
        LecturePlainObject *lecture = [LecturePlainObject new];
        lecture.lectureId = [NSString stringWithFormat:@"%li", index];
        
        [lectures addObject:lecture];
    }
    
    return lectures;

}

@end
