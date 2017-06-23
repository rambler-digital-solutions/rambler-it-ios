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
#import <ViperMcFlurry/ViperMcFlurry.h>
#import <OCMock/OCMock.h>

#import "StubTestHelper.h"
#import "SearchRouter.h"
#import "EventModuleInput.h"
#import "ReportsSearchModuleInput.h"

@interface SearchRouterTests : XCTestCase

@property (nonatomic, strong) SearchRouter *router;
@property (nonatomic, strong) id transitionHandlerMock;

@end

@implementation SearchRouterTests

- (void)setUp {
    [super setUp];
    
    self.router = [SearchRouter new];
    self.transitionHandlerMock = OCMProtocolMock(@protocol(RamblerViperModuleTransitionHandlerProtocol));
    
    self.router.transitionHandler = self.transitionHandlerMock;
}

- (void)tearDown {
    self.router = nil;
    
    [self.transitionHandlerMock stopMocking];
    self.transitionHandlerMock = nil;
    
    [super tearDown];
}

#pragma mark - ReportListRouter

- (void)testSuccessOpenEventModuleWithEventObjectId {
    // given
    NSString *objectId = @"3k3523";
    
    id <EventModuleInput> moduleInputMock = OCMProtocolMock(@protocol(EventModuleInput));
    
    StubTestHelper *stubTestHelper = [StubTestHelper new];
    [stubTestHelper stubTransitionHandler:self.transitionHandlerMock withModuleInputMock:moduleInputMock];
    
    // when
    [self.router openEventModuleWithEventObjectId:objectId];
    
    // then
    OCMVerify([moduleInputMock configureCurrentModuleWithEventObjectId:objectId]);
}

- (void)testThatRouterConfigureReportsSearchModuleCorrectly {
    // given
    NSString *searchString = @"3k3523";
    
    id <ReportsSearchModuleInput> moduleInputMock = OCMProtocolMock(@protocol(ReportsSearchModuleInput));
    
    StubTestHelper *stubTestHelper = [StubTestHelper new];
    [stubTestHelper stubTransitionHandler:self.transitionHandlerMock
                      withModuleInputMock:moduleInputMock];
    
    // when
    [self.router configureReportsSearchModuleWithSearchTerm:searchString
                                                 moduleOutput:nil];
    
    // then
    OCMVerify([moduleInputMock configureReportsSearchModuleWithSearchTerm:searchString]);
}

@end
