//
//  MessagesRouterTests.m
//  Conferences
//
//  Created by Trishina Ekaterina on 16/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ViperMcFlurry/ViperMcFlurry.h>
#import <OCMock/OCMock.h>
#import <Messages/Messages.h>

#import "MessagesRouter.h"
#import "MessagesRouterInput.h"

@interface MessagesRouterTests : XCTestCase

@property (nonatomic, strong) MessagesRouter *router;

@end

@implementation MessagesRouterTests

- (void)setUp {
    [super setUp];

    self.router = [MessagesRouter new];
}

- (void)tearDown {
    self.router = nil;
    
    [super tearDown];
}

#pragma mark - MessagesRouterInput

- (void)testSuccessOpenEventModuleWithEventObjectId {
    // given
    NSString *identifier = @"EventModelObject_42";
    NSURL *url = [NSURL URLWithString:identifier];
    NSExtensionContext *context = [NSExtensionContext new];

    // when
    [self.router openEventModuleWithIdentifier:identifier
                           andExtensionContext:context];

    // then
    OCMVerify([context openURL:url
             completionHandler:nil]);
}

@end
