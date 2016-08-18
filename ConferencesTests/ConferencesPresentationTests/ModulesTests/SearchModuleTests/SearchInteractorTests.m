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

#import "SearchInteractor.h"
#import "SearchInteractorOutput.h"

#import "EventService.h"
#import "EventTypeDeterminator.h"
#import "EventPlainObject.h"
#import "EventModelObject.h"
#import "ROSPonsomizer.h"
#import "SuggestService.h"

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface SearchInteractorTests : XCTestCase

@property (strong, nonatomic) SearchInteractor *interactor;
@property (strong, nonatomic) EventTypeDeterminator *mockEventTypeDeterminator;
@property (strong, nonatomic) id <SearchInteractorOutput> mockOutput;
@property (strong, nonatomic) id <EventService> mockEventService;
@property (strong, nonatomic) id mockSuggestService;
@property (strong, nonatomic) id <ROSPonsomizer> mockPonsomizer;

@end

@implementation SearchInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [SearchInteractor new];
    self.mockOutput = OCMProtocolMock(@protocol(SearchInteractorOutput));
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockEventTypeDeterminator = OCMClassMock([EventTypeDeterminator class]);
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockSuggestService = OCMProtocolMock(@protocol(SuggestService));
    
    self.interactor.output = self.mockOutput;
    self.interactor.eventService = self.mockEventService;
    self.interactor.eventTypeDeterminator = self.mockEventTypeDeterminator;
    self.interactor.ponsomizer = self.mockPonsomizer;
    self.interactor.suggestService = self.mockSuggestService;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockOutput = nil;
    self.mockEventService = nil;
    self.mockEventTypeDeterminator = nil;
    self.mockPonsomizer = nil;
    self.mockSuggestService = nil;

    [super tearDown];
}

- (void)testThatInteractorObtainsSuggests {
    // given
    NSArray *testArray = @[@"1"];
    OCMStub([[self.mockSuggestService ignoringNonObjectArgs] obtainRandomSuggestsWithCount:0]).andReturn(testArray);
    
    // when
    NSArray *result = [self.interactor obtainSuggests];
    
    // then
    XCTAssertEqualObjects(result, testArray);
}

@end
