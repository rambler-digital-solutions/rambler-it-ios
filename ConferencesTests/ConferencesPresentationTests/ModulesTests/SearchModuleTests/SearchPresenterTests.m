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

#import "SearchPresenter.h"
#import "SearchViewInput.h"
#import "SearchInteractorInput.h"
#import "SearchRouterInput.h"
#import "EventPlainObject.h"

@interface SearchPresenterTests : XCTestCase

@property (nonatomic, strong) SearchPresenter *presenter;
@property (nonatomic, strong) id <SearchInteractorInput> mockInteractor;
@property (nonatomic, strong) id mockView;
@property (nonatomic, strong) id <SearchRouterInput> mockRouter;
@property (nonatomic, strong) id<ReportsSearchModuleInput> mockReportsSearchModule;

@end

@implementation SearchPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [SearchPresenter new];
    self.mockInteractor = OCMProtocolMock(@protocol(SearchInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(SearchViewInput));
    self.mockRouter = OCMProtocolMock(@protocol(SearchRouterInput));
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

- (void)testSuccessSetupViewWithSuggestsIfThereAreAny {
    // given
    NSArray *testArray = @[@"1"];
    OCMStub([self.mockInteractor obtainSuggests]).andReturn(testArray);
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerify([self.mockView setupViewWithSuggests:testArray]);
}

- (void)testSuccessDoesNotSetupViewWithSuggestsIfThereAreNo {
    // given
    NSArray *testArray = @[];
    OCMStub([self.mockInteractor obtainSuggests]).andReturn(testArray);
    
    [[self.mockView reject] setupViewWithSuggests:OCMOCK_ANY];
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerifyAll(self.mockView);
}

#pragma mark - ReportListInteractorOutput

- (void)testCorrectDidTapSearchBarCancelButton {
    // given
    
    // when
    [self.presenter didTapSearchBarCancelButton];
    
    // then
    OCMVerify([self.mockReportsSearchModule closeSearchModule]);
    OCMVerify([self.mockView updateSearchBarWithText:@""]);
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

- (void)testSuccessDidTapSuggest {
    // given
    NSString *testSuggest = @"text";
    
    // when
    [self.presenter didTapSuggestWithText:testSuggest];
    
    // then
    OCMVerify([self.mockView showSearchModuleView]);
    OCMVerify([self.mockView updateSearchBarWithText:testSuggest]);
    OCMVerify([self.mockReportsSearchModule updateModuleWithSearchTerm:testSuggest]);
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
