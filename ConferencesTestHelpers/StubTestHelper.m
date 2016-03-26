//
//  StubTestHelper.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "StubTestHelper.h"

#import <ViperMcFlurry/ViperMcFlurry.h>
#import <OCMock/OCMock.h>

typedef void (^ProxyBlock)(NSInvocation *);

@implementation StubTestHelper

- (void)stubTransitionHandler:(id)transitionHandlerMock withModuleInputMock:(id)moduleInputMock {
    id promiseMock = OCMClassMock([RamblerViperOpenModulePromise class]);
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        RamblerViperModuleLinkBlock completionBlock;
        [invocation getArgument:&completionBlock atIndex:2];
        
        completionBlock(moduleInputMock);
    };
    
    OCMStub([promiseMock thenChainUsingBlock:OCMOCK_ANY]).andDo(proxyBlock);
    OCMStub([transitionHandlerMock openModuleUsingSegue:OCMOCK_ANY]).andReturn(promiseMock);
}

@end
