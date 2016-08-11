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

#import "ReportListPresenter.h"
#import "ReportListViewInput.h"
#import "ReportListInteractorInput.h"
#import "ReportListRouterInput.h"
#import "EventPlainObject.h"

@interface ReportListPresenterTests : XCTestCase

@property (nonatomic, strong) ReportListPresenter *presenter;
@property (nonatomic, strong) id <ReportListInteractorInput> mockInteractor;
@property (nonatomic, strong) id <ReportListViewInput> mockView;
@property (nonatomic, strong) id <ReportListRouterInput> mockRouter;
@property (nonatomic, strong) id<ReportsSearchModuleInput> mockReportsSearchModule;

@end

@implementation ReportListPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [ReportListPresenter new];
    self.mockInteractor = OCMProtocolMock(@protocol(ReportListInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(ReportListViewInput));
    self.mockRouter = OCMProtocolMock(@protocol(ReportListRouterInput));
    self.mockReportsSearchModule = OCMProtocolMock(@protocol(ReportsSearchModuleInput));
    
    self.presenter.view = self.mockView;
    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
    self.presenter.reportsSearchModule = self.mockReportsSearchModule;
}

- (void)tearDown {
    self.presenter = nil;
    self.mockInteractor = nil;
    self.mockView = nil;
    self.mockRouter = nil;
    self.mockReportsSearchModule = nil;
    
    [super tearDown];
}

#pragma mark - ReportListViewOutput

- (void)testSuccessSetupView {
    // given
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerify([self.mockInteractor obtainEventList]);
    OCMVerify([self.mockView setupViewWithEventList:OCMOCK_ANY]);
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

#pragma mark - EventListInteractorOutput

- (void)testCorrectDidTapSearchBarCancelButton {
    // given
    
    // when
    [self.presenter didTapSearchBarCancelButton];
    
    // then
    OCMVerify([self.mockReportsSearchModule closeSearchModule]);
}

#pragma mark - SearchBar Delegate

- (void)testCorrectSearchBarChangedWithNilText {
    // given
    NSString *searchString = nil;
    // when
    [self.presenter didChangeSearchBarWithSearchTerm:searchString];
    
    // then
    OCMVerify([self.mockReportsSearchModule updateModuleWithSearchTerm:searchString]);
}

- (void)testCorrectSearchBarChangedWithEmptyText {
    // given
    NSString *searchString = @"";
    // when
    [self.presenter didChangeSearchBarWithSearchTerm:searchString];
    
    // then
    OCMVerify([self.mockReportsSearchModule updateModuleWithSearchTerm:searchString]);
}

- (void)testCorrectSearchBarChangedWithText {
    // given
    NSString *searchString = @"test";
    // when
    [self.presenter didChangeSearchBarWithSearchTerm:searchString];
    
    // then
    OCMVerify([self.mockReportsSearchModule updateModuleWithSearchTerm:searchString]);
}

- (void)testCorrectDidTapClearScreenSearchModule {
    // given
    
    // when
    [self.presenter didTapClearScreenSearchModule];
    
    // then
    OCMVerify([self.mockView hideSearchModuleView]);
}

#pragma mark - ReportsSearchModuleOuput

- (void)testSuccessDidLoadReportsSearchModuleInput {
    // given
    id<ReportsSearchModuleInput> reportsSearchModule = OCMProtocolMock(@protocol(ReportsSearchModuleInput));
    
    // when
    [self.presenter didLoadReportsSearchModuleInput:reportsSearchModule];
    
    // then
    XCTAssertEqual(self.presenter.reportsSearchModule, reportsSearchModule);
}
@end
