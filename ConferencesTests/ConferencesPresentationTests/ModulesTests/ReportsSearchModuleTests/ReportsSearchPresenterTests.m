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

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ReportsSearchPresenter.h"
#import "ReportsSearchViewInput.h"
#import "ReportsSearchViewOutput.h"
#import "ReportsSearchInteractorInput.h"
#import "ReportsSearchRouterInput.h"
#import "EventPlainObject.h"

@interface ReportsSearchPresenterTests : XCTestCase

@property (nonatomic, strong) ReportsSearchPresenter *presenter;
@property (nonatomic, strong) id<ReportsSearchInteractorInput> mockInteractor;
@property (nonatomic, strong) id<ReportsSearchViewInput> mockView;
@property (nonatomic, strong) id<ReportsSearchRouterInput> mockRouter;
@property (nonatomic, strong) id<ReportsSearchModuleOutput> mockModuleOutput;

@end

@implementation ReportsSearchPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [ReportsSearchPresenter new];
    self.mockInteractor = OCMProtocolMock(@protocol(ReportsSearchInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(ReportsSearchViewInput));
    self.mockRouter = OCMProtocolMock(@protocol(ReportsSearchRouterInput));
    self.mockModuleOutput = OCMProtocolMock(@protocol(ReportsSearchModuleOutput));
    
    self.presenter.view = self.mockView;
    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
    self.presenter.moduleOutput = self.mockModuleOutput;
}

- (void)tearDown {
    self.presenter = nil;
    self.mockInteractor = nil;
    self.mockView = nil;
    self.mockRouter = nil;
    self.mockModuleOutput = nil;
    
    [super tearDown];
}


- (void)testSuccessSetupView {
    // given
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerify([self.mockModuleOutput didLoadReportsSearchModuleInput:self.presenter]);
    OCMVerify([self.mockView setupView]);
}

- (void)testSuccessDidTriggerTapCellWithEvent {
    // given
    NSString *eventId = @"123";
    EventPlainObject *event = [EventPlainObject new];
    event.eventId = eventId;
    
    // when
    [self.presenter didTriggerTapCellWithEvent:event];
    
    // then
    OCMVerify([self.mockRouter openEventModuleWithEventObjectId:eventId]);
}

- (void)testSuccessCloseSearchModule {
    // given
    
    // when
    [self.presenter closeSearchModule];
    
    // then
    OCMVerify([self.mockView closeSearchView]);
}

- (void)testSuccessDidTapClearPlaceholderView {
    // given
    
    // when
    [self.presenter didTapClearPlaceholderView];
    
    // then
    OCMVerify([self.mockModuleOutput didTapClearScreenSearchModule]);
}

- (void)testSuccessUpdateModuleWithNilText {
    // given
    
    // when
    [self.presenter updateModuleWithSearchTerm:nil];
    
    // then
    OCMVerify([self.mockView showClearPlaceholder]);
}

- (void)testSuccessUpdateModuleWithEmptyText {
    // given
    
    // when
    [self.presenter updateModuleWithSearchTerm:@""];
    
    // then
    OCMVerify([self.mockView showClearPlaceholder]);
}

- (void)testSuccessUpdateModuleWithText {
    // given
    NSString *searchText = @"text";
    // when
    [self.presenter updateModuleWithSearchTerm:searchText];
    
    // then
    OCMVerify([self.mockInteractor obtainFoundObjectListWithSearchText:searchText]);
    OCMVerify([self.mockView updateViewWithObjectList:OCMOCK_ANY searchText:searchText]);
}

- (void)testThatTagSelectionIsCorrect {
    // given
    NSString *tag = @"someTag";
    
    // when
    [self.presenter didSelectTag:tag];
    
    // then
    OCMVerify([self.mockModuleOutput didSelectSearchString:tag]);
}

@end
