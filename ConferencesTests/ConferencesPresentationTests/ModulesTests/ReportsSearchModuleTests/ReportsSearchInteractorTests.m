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

#import "ReportsSearchInteractor.h"
#import "ReportsSearchInteractorOutput.h"

#import "PredicateConfigurator.h"
#import "SearchFacade.h"

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface ReportsSearchInteractorTests : XCTestCase

@property (nonatomic, strong) ReportsSearchInteractor *interactor;
@property (nonatomic, strong) id <ReportsSearchInteractorOutput> mockOutput;
@property (nonatomic, strong) id <PredicateConfigurator> mockPredicateConfigurator;
@property (nonatomic, strong) id <SearchFacade> mockSearchFacade;

@end

@implementation ReportsSearchInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [ReportsSearchInteractor new];
    self.mockOutput = OCMProtocolMock(@protocol(ReportsSearchInteractorOutput));
    self.mockPredicateConfigurator = OCMProtocolMock(@protocol(PredicateConfigurator));
    self.mockSearchFacade = OCMProtocolMock(@protocol(SearchFacade));
    
    self.interactor.output = self.mockOutput;
    self.interactor.predicateConfigurator = self.mockPredicateConfigurator;
    self.interactor.searchFacade = self.mockSearchFacade;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockOutput = nil;
    self.mockPredicateConfigurator = nil;
    self.mockSearchFacade = nil;

    [super tearDown];
}

- (void)testSuccessObtainEventList {
    //given
    NSArray *expectedObjects = @[@1, @2, @3];
    
    NSString *text = @"randomText";
    
    NSArray *eventsPredicates = @[@5, @6];
    NSArray *speakersPredicates = @[@5, @6];
    NSArray *lecturesPredicates = @[@5, @6];
    
    OCMStub([self.mockPredicateConfigurator configureEventsPredicatesForSearchText:text]).andReturn(eventsPredicates);
    OCMStub([self.mockPredicateConfigurator configureSpeakersPredicatesForSearchText:text]).andReturn(speakersPredicates);
    OCMStub([self.mockPredicateConfigurator configureLecturesPredicatesForSearchText:text]).andReturn(lecturesPredicates);
    
    OCMStub([self.mockSearchFacade eventsForPredicates:eventsPredicates]).andReturn(@[@1]);
    OCMStub([self.mockSearchFacade speakersForPredicates:speakersPredicates]).andReturn(@[@2]);
    OCMStub([self.mockSearchFacade lecturesForPredicates:lecturesPredicates]).andReturn(@[@3]);
    
    // when
    id result = [self.interactor obtainFoundObjectListWithSearchText:text];
    
    // then
    
    XCTAssertEqualObjects(expectedObjects, result);
}

@end
