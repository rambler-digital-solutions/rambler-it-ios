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

#import "EventGalleryFeedbackGeneratorImplementation.h"
#import "EventGalleryPageSizeCalculator.h"

#import <OCMock/OCMock.h>

@interface EventGalleryFeedbackGeneratorTests : XCTestCase

@property (nonatomic, strong) EventGalleryFeedbackGeneratorImplementation *generator;
@property (nonatomic, strong) id selectionFeedbackGeneratorMock;
@property (nonatomic, strong) id notificationFeedbackGeneratorMock;
@property (nonatomic, strong) id calculatorMock;

@end

@implementation EventGalleryFeedbackGeneratorTests

- (void)setUp {
    [super setUp];
    
    self.generator = [EventGalleryFeedbackGeneratorImplementation new];
    
    self.calculatorMock = OCMClassMock([EventGalleryPageSizeCalculator class]);
    self.selectionFeedbackGeneratorMock = OCMClassMock([UISelectionFeedbackGenerator class]);
    self.notificationFeedbackGeneratorMock = OCMClassMock([UINotificationFeedbackGenerator class]);
    
    self.generator.calculator = self.calculatorMock;
    self.generator.selectionFeedbackGenerator = self.selectionFeedbackGeneratorMock;
    self.generator.notificationFeedbackGenerator = self.notificationFeedbackGeneratorMock;
}

- (void)tearDown {
    [self.calculatorMock stopMocking];
    self.calculatorMock = nil;
    
    [self.notificationFeedbackGeneratorMock stopMocking];
    self.notificationFeedbackGeneratorMock = nil;
    
    [self.selectionFeedbackGeneratorMock stopMocking];
    self.selectionFeedbackGeneratorMock = nil;
    
    self.generator = nil;
    
    [super tearDown];
}

- (void)testThatGeneratorGenerateNotificationErrorFeedback {
    // given
    
    // when
    [self.generator generateNotificationErrorFeedback];
    
    // then
    OCMVerify([self.notificationFeedbackGeneratorMock prepare]);
    OCMVerify([self.notificationFeedbackGeneratorMock notificationOccurred:UINotificationFeedbackTypeError]);
}

- (void)testThatGeneratorNotGenerateSelectionFeedbackWhenOffsetIsNegative {
    // given
    CGFloat contentOffsetX = -10.0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[UICollectionViewLayout new]];
    
    // when
    [self.generator generateSelectionFeedbackForContentOffset:contentOffsetX inView:collectionView];
    
    // then
    OCMReject([self.selectionFeedbackGeneratorMock prepare]);
}

- (void)testThatGeneratorGenerateSelectionFeedback {
    // given
    CGFloat contentOffsetX = 500.0;
    CGFloat collectionViewContentWidth = 1000.0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[UICollectionViewLayout new]];
    CGSize collectionViewContentSize = (CGSize){collectionViewContentWidth, collectionView.frame.size.height};
    collectionView.contentSize = collectionViewContentSize;
    OCMStub([self.calculatorMock calculatePageSizeForViewWidth:collectionView.frame.size.width]).andReturn(250.0);
    
    // when
    [self.generator generateSelectionFeedbackForContentOffset:contentOffsetX inView:collectionView];
    
    // then
    OCMVerify([self.selectionFeedbackGeneratorMock prepare]);
    OCMVerify([self.selectionFeedbackGeneratorMock selectionChanged]);
}

- (void)testThatGeneratorNotGenerateSelectionFeedback {
    // given
    CGFloat contentOffsetX = 50.0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[UICollectionViewLayout new]];
    collectionView.contentSize = (CGSize){1000.0, 0.0};
    OCMStub([self.calculatorMock calculatePageSizeForViewWidth:collectionView.frame.size.width]).andReturn(250.0);
    
    // when
    [self.generator generateSelectionFeedbackForContentOffset:contentOffsetX inView:collectionView];
    
    // then
    OCMReject([self.selectionFeedbackGeneratorMock selectionChanged]);
    
}

@end
