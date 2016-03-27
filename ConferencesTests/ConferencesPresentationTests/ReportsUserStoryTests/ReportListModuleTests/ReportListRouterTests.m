//
//  ReportListRouterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ViperMcFlurry/ViperMcFlurry.h>
#import <OCMock/OCMock.h>

#import "StubTestHelper.h"
#import "ReportListRouter.h"
#import "EventModuleInput.h"

@interface ReportListRouterTests : XCTestCase

@property (nonatomic, strong) ReportListRouter *router;
@property (nonatomic, strong) id transitionHandlerMock;

@end

@implementation ReportListRouterTests

- (void)setUp {
    [super setUp];
    
    self.router = [ReportListRouter new];
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

@end
