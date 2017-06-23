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

#import "EventRouter.h"
#import "StubTestHelper.h"
#import "LectureModuleInput.h"

@interface EventRouterTests : XCTestCase

@property (nonatomic, strong) EventRouter *router;
@property (nonatomic, strong) id transitionHandlerMock;

@end

@implementation EventRouterTests

- (void)setUp {
    [super setUp];
    
    self.router = [EventRouter new];
    self.transitionHandlerMock = OCMProtocolMock(@protocol(RamblerViperModuleTransitionHandlerProtocol));
    
    self.router.transitionHandler = self.transitionHandlerMock;
}

- (void)tearDown {
    self.router = nil;
    
    [self.transitionHandlerMock stopMocking];
    self.transitionHandlerMock = nil;
    
    [super tearDown];
}

#pragma mark - EventRouterInput

- (void)testSuccessOpenLectureModuleWithLectureObjectId {
    // given
    NSString *objectId = @"3k3523";
    
    id <LectureModuleInput> moduleInputMock = OCMProtocolMock(@protocol(LectureModuleInput));
    
    StubTestHelper *stubTestHelper = [StubTestHelper new];
    [stubTestHelper stubTransitionHandler:self.transitionHandlerMock withModuleInputMock:moduleInputMock];
    
    // when
    [self.router openLectureModuleWithLectureObjectId:objectId];
    
    // then
    OCMVerify([moduleInputMock configureCurrentModuleWithLectureObjectId:objectId]);
    [(id)moduleInputMock stopMocking];
}

@end
