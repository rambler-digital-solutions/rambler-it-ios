//
//  EventRouterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

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
