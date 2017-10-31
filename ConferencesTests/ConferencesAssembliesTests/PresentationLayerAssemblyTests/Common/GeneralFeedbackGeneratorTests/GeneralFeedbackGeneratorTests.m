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

#import "GeneralFeedbackGeneratorImplementation.h"
#import "FeedbackGeneratorsFactory.h"

@interface GeneralFeedbackGeneratorTests : XCTestCase

@property (nonatomic, strong) GeneralFeedbackGeneratorImplementation *feedbackGenerator;
@property (nonatomic, strong) id feedbackGeneratorsFactoryMock;

@end

@implementation GeneralFeedbackGeneratorTests

- (void)setUp {
    [super setUp];
    
    self.feedbackGenerator = [GeneralFeedbackGeneratorImplementation new];
    self.feedbackGeneratorsFactoryMock = OCMProtocolMock(@protocol(FeedbackGeneratorsFactory));
    
    self.feedbackGenerator.feedbackGeneratorsFactory = self.feedbackGeneratorsFactoryMock;
}

- (void)tearDown {
    self.feedbackGeneratorsFactoryMock = nil;
    self.feedbackGenerator = nil;
    
    [super tearDown];
}

- (void)testThatGeneratorGeneratesSelectionFeedback {
    if (@available(iOS 10, *)) {
        // given
        id selectionFeedbackGenerator = OCMClassMock([UISelectionFeedbackGenerator class]);
        OCMStub([self.feedbackGeneratorsFactoryMock selectionFeedbackGenerator]).andReturn(selectionFeedbackGenerator);

        // when
        [self.feedbackGenerator generateFeedbackWithType:TapticEngineFeedbackTypeSelection];

        // then
        OCMVerify([selectionFeedbackGenerator prepare]);
        OCMVerify([selectionFeedbackGenerator selectionChanged]);
        [selectionFeedbackGenerator stopMocking];
        selectionFeedbackGenerator = nil;
    }
}

- (void)testThatGeneratorGeneratesLightImpactFeedback {
    if (@available(iOS 10, *)) {
        // given
        id lightImpactFeedbackGenerator = OCMClassMock([UIImpactFeedbackGenerator class]);
        OCMStub([self.feedbackGeneratorsFactoryMock lightImpactFeedbackGenerator]).andReturn(lightImpactFeedbackGenerator);

        // when
        [self.feedbackGenerator generateFeedbackWithType:TapticEngineFeedbackTypeLightImpact];

        // then
        OCMVerify([lightImpactFeedbackGenerator prepare]);
        OCMVerify([lightImpactFeedbackGenerator impactOccurred]);
        [lightImpactFeedbackGenerator stopMocking];
        lightImpactFeedbackGenerator = nil;
    }
}

- (void)testThatGeneratorGeneratesNotificationErrorFeedback {
    if (@available(iOS 10, *)) {
        // given
        id notificationErrorFeedbackGenerator = OCMClassMock([UINotificationFeedbackGenerator class]);
        OCMStub([self.feedbackGeneratorsFactoryMock notificationFeedbackGenerator]).andReturn(notificationErrorFeedbackGenerator);

        // when
        [self.feedbackGenerator generateFeedbackWithType:TapticEngineFeedbackTypeNotificationError];

        // then
        OCMVerify([notificationErrorFeedbackGenerator prepare]);
        OCMVerify([notificationErrorFeedbackGenerator notificationOccurred:UINotificationFeedbackTypeError]);
        [notificationErrorFeedbackGenerator stopMocking];
        notificationErrorFeedbackGenerator = nil;
    }
}

- (void)testThatGeneratorCorrectlyHandlesUnknownFeedbackType {
    // given
    OCMReject([self.feedbackGeneratorsFactoryMock selectionFeedbackGenerator]);
    
    // when
    [self.feedbackGenerator generateFeedbackWithType:TapticEngineFeedbackTypeUnknown];
    
    // then
    OCMVerify(self.feedbackGeneratorsFactoryMock);
}

@end
