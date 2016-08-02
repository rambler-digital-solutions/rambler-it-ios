//
//  LectureRouterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <ViperMcFlurry/ViperMcFlurry.h>
#import "StubTestHelper.h"

#import "LectureRouter.h"
#import "SpeakerInfoModuleInput.h"

@interface LectureRouterTests : XCTestCase

@property (nonatomic, strong) LectureRouter *router;
@property (nonatomic, strong) id transitionHandlerMock;

@end

@implementation LectureRouterTests

- (void)setUp {
    [super setUp];
    
    self.router = [LectureRouter new];
    self.transitionHandlerMock = OCMProtocolMock(@protocol(RamblerViperModuleTransitionHandlerProtocol));
    
    self.router.transitionHandler = self.transitionHandlerMock;
}

- (void)tearDown {
    self.router = nil;
    
    [self.transitionHandlerMock stopMocking];
    self.transitionHandlerMock = nil;
    
    [super tearDown];
}

#pragma mark - LectureRouterInput

- (void)testSuccessOpenSpeakerInfoModuleWithEventObjectId {
    // given
    NSString *objectId = @"3k3523";
    
    id <SpeakerInfoModuleInput> moduleInputMock = OCMProtocolMock(@protocol(SpeakerInfoModuleInput));
    
    StubTestHelper *stubTestHelper = [StubTestHelper new];
    [stubTestHelper stubTransitionHandler:self.transitionHandlerMock withModuleInputMock:moduleInputMock];
    
    // when
    [self.router openSpeakerInfoModuleWithSpeakerObjectId:objectId];
    
    // then
    OCMVerify([moduleInputMock configureCurrentModuleWithSpeakerId:objectId]);
}

@end
