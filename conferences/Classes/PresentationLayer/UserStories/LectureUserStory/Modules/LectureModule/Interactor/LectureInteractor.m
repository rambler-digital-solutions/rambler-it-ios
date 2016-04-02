// Copyright (c) 2016 RAMBLER&Co
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

#import "LectureInteractor.h"
#import "LectureInteractorOutput.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"

@interface LectureInteractor()

@end

@implementation LectureInteractor

#pragma mark - LectureInteractorInput

- (void)obtainLectureWithObjectId:(NSString *)objectId {
    /**
     @author Artem Karpushin
     
     There is no service to fetch lecture yet, so create mockLecture to simulate the operation of the service
     */
    LecturePlainObject *mockLecture = [LecturePlainObject new];
    mockLecture.lectureDescription = @"Method swizzling is the process of changing the implementation of an existing selector. It’s a technique made possible by the fact that method invocations in Objective-C can be changed at runtime, by changing how selectors are mapped to underlying functions in a class’s dispatch table. For example, let’s say we wanted to track how many times each view controller is presented to a user in an iOS app: Each view controller could add tracking code to its own implementation of viewDidAppear:, but that would make for a ton of duplicated boilerplate code. Subclassing would be another possibility, but it would require subclassing UIViewController, UITableViewController, UINavigationController, and every other view controller class—an approach that would also suffer from code duplication.";
    mockLecture.name = @"Method Swizzling";
    mockLecture.startDate = [NSDate date];
    
    SpeakerPlainObject * mockSpeaker = [SpeakerPlainObject new];
    mockSpeaker.name = @"Ray Wenderlich";
    mockSpeaker.companyName = @"Rambler&Co";
    
    mockLecture.speakers = @[mockSpeaker];
    
    [self.output didObtainLecture:mockLecture];
}

@end