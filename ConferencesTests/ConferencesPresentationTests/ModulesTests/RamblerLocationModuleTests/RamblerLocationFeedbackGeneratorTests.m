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
#import "GeneralFeedbackGenerator.h"

#import "RamblerLocationFeedbackGeneratorImplementation.h"

@interface RamblerLocationFeedbackGeneratorTests : XCTestCase

@property (nonatomic, strong) RamblerLocationFeedbackGeneratorImplementation *generator;
@property (nonatomic, strong) id feedbackGeneratorMock;

@end

@implementation RamblerLocationFeedbackGeneratorTests

- (void)setUp {
    [super setUp];
    
    self.generator = [RamblerLocationFeedbackGeneratorImplementation new];
    self.feedbackGeneratorMock = OCMProtocolMock(@protocol(GeneralFeedbackGenerator));
    
    self.generator.feedbackGenerator = self.feedbackGeneratorMock;
}

- (void)tearDown {
    self.feedbackGeneratorMock = nil;
    
    self.generator = nil;
    
    [super tearDown];
}

- (void)testThatGeneratorGenerateSelectionFeedback {
    // given
    CGFloat contentOffsetX = 500.0;
    CGFloat collectionViewContentWidth = 1000.0;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGSize collectionViewContentSize = (CGSize){collectionViewContentWidth, scrollView.frame.size.height};
    scrollView.contentSize = collectionViewContentSize;
    scrollView.contentOffset = (CGPoint){contentOffsetX, 0.0};
    
    // when
    [self.generator generateSelectionFeedbackInScrollView:scrollView];
    
    // then
    OCMVerify([self.feedbackGeneratorMock generateFeedbackWithType:FeedbackTypeSelection]);
}

- (void)testThatGeneratorNotGenerateSelectionFeedback {
    // given
    CGFloat contentOffsetX = 50.0;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = (CGSize){1000.0, 0.0};
    scrollView.contentOffset = (CGPoint){contentOffsetX, 0.0};
    
    [[[self.feedbackGeneratorMock reject] ignoringNonObjectArgs] generateFeedbackWithType:0];
    
    // when
    [self.generator generateSelectionFeedbackInScrollView:scrollView];
    
    // then
    OCMExpect(self.feedbackGeneratorMock);
}

@end
