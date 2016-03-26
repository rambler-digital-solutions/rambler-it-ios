//
//  AnnouncementListRouterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ViperMcFlurry/ViperMcFlurry.h>
#import <OCMock/OCMock.h>

#import "AnnouncementListRouter.h"
#import "EventModuleInput.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface AnnouncementListRouterTests : XCTestCase

@property (nonatomic, strong) AnnouncementListRouter *router;
@property (nonatomic, strong) id transitionHandlerMock;

@end

@implementation AnnouncementListRouterTests

- (void)setUp {
    [super setUp];
    
    self.router = [AnnouncementListRouter new];
    self.transitionHandlerMock = OCMProtocolMock(@protocol(RamblerViperModuleTransitionHandlerProtocol));
    
    self.router.transitionHandler = self.transitionHandlerMock;
}

- (void)tearDown {
    self.router = nil;
    
    [self.transitionHandlerMock stopMocking];
    self.transitionHandlerMock = nil;

    [super tearDown];
}

#pragma mark - AnnouncementListRouterInput

- (void)testSuccessOpenEventModuleWithEventObjectId {
    // given
    NSString *objectId = @"3k3523";
    
    id <EventModuleInput> moduleInputMock = OCMProtocolMock(@protocol(EventModuleInput));
        
    [self stubTransitionHandler:self.transitionHandlerMock withModuleInputMock:moduleInputMock];
    
    // when
    [self.router openEventModuleWithEventObjectId:objectId];
    
    // then
    OCMVerify([moduleInputMock configureCurrentModuleWithEventObjectId:objectId]);
}

#pragma mark - Helpers

- (void)stubTransitionHandler:(id)transitionHandler withModuleInputMock:(id)moduleInputMock {
    id promiseMock = OCMClassMock([RamblerViperOpenModulePromise class]);
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        RamblerViperModuleLinkBlock completionBlock;
        [invocation getArgument:&completionBlock atIndex:2];
        
        completionBlock(moduleInputMock);
    };
    
    OCMStub([promiseMock thenChainUsingBlock:OCMOCK_ANY]).andDo(proxyBlock);
    OCMStub([transitionHandler openModuleUsingSegue:OCMOCK_ANY]).andReturn(promiseMock);
}

@end
