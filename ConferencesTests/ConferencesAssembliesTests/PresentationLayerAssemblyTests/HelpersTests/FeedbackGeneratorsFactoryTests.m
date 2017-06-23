// Copyright (c) 2017 RAMBLER&Co
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

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "FeedbackGeneratorsFactoryImplementation.h"

#import <UIKit/UIKit.h>

@interface FeedbackGeneratorsFactoryTests : XCTestCase

@property (nonatomic, strong) FeedbackGeneratorsFactoryImplementation *factory;

@end

@implementation FeedbackGeneratorsFactoryTests

- (void)setUp {
    [super setUp];
    
    self.factory = [FeedbackGeneratorsFactoryImplementation new];
}

- (void)tearDown {
    self.factory = nil;
    
    [super tearDown];
}

- (void)testThatFactoryGenerateSelectionFeedbackGenerator {
    // given
    
    // when
    id result = [self.factory selectionFeedbackGenerator];
    
    // then
    XCTAssertTrue([result isMemberOfClass:[UISelectionFeedbackGenerator class]]);
}

- (void)testThatFactoryGenerateLightImpactFeedbackGenerator {
    // given
    id generator = OCMClassMock([UIImpactFeedbackGenerator class]);
    OCMStub(ClassMethod([generator alloc])).andReturn(generator);
    
    // when
    [self.factory lightImpactFeedbackGenerator];
    
    // then
    OCMVerify([(UIImpactFeedbackGenerator *)generator initWithStyle:UIImpactFeedbackStyleLight]);
    [generator stopMocking];
    generator = nil;
}

- (void)testThatFactoryGenerateNotificationFeedbackGenerator {
    // given
    
    // when
    id result = [self.factory notificationFeedbackGenerator];
    
    // then
    XCTAssertTrue([result isMemberOfClass:[UINotificationFeedbackGenerator class]]);
}

@end
