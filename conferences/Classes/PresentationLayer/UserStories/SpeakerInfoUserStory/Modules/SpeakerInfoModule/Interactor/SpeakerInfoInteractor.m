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

#import "SpeakerInfoInteractor.h"
#import "SpeakerInfoInteractorOutput.h"
#import "SpeakerPlainObject.h"

@interface SpeakerInfoInteractor()

@end

@implementation SpeakerInfoInteractor

#pragma mark - SpeakerInfoInteractorInput

- (void)obtainSpeakerWithObjectId:(NSString *)objectId {
    /**
     @author Artem Karpushin
     
     There is no service to fetch Speaker yet, so create mockSpeaker to simulate the operation of the service
     */
    
    SpeakerPlainObject * mockSpeaker = [SpeakerPlainObject new];
    mockSpeaker.name = @"Ray Wenderlich";
    mockSpeaker.company = @"Rambler&Co";
    mockSpeaker.biography = @"Method swizzling is the process of changing the implementation of an existing selector. It’s a technique made possible by the fact that method invocations in Objective-C can be changed at runtime, by changing how selectors are mapped to underlying functions in a class’s dispatch table.";
    
    [self.output didObtainSpeaker:mockSpeaker];
}

@end