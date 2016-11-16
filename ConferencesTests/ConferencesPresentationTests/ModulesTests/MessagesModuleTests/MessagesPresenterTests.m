//
//  MessagesPresenterTests.m
//  Conferences
//
//  Created by Trishina Ekaterina on 16/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Messages/Messages.h>

#import "MessagesPresenter.h"
#import "MessagesViewInput.h"
#import "MessagesInteractorInput.h"
#import "MessagesRouterInput.h"
#import "EventPlainObject.h"

@interface MessagesPresenterTests : XCTestCase

@property (strong, nonatomic) MessagesPresenter *presenter;
@property (strong, nonatomic) id <MessagesInteractorInput> mockInteractor;
@property (strong, nonatomic) id <MessagesViewInput> mockView;
@property (strong, nonatomic) id <MessagesRouterInput> mockRouter;

@end

@implementation MessagesPresenterTests

- (void)setUp {
    [super setUp];

    self.presenter = [MessagesPresenter new];
    self.mockInteractor = OCMProtocolMock(@protocol(MessagesInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(MessagesViewInput));
    self.mockRouter = OCMProtocolMock(@protocol(MessagesRouterInput));

    self.presenter.view = self.mockView;
    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
}

- (void)tearDown {
    self.presenter = nil;
    self.mockInteractor = nil;
    self.mockView = nil;
    self.mockRouter = nil;
    
    [super tearDown];
}

- (void)testSuccessSetupView {
    // given

    // when
    [self.presenter setupView];

    // then
    OCMVerify([self.mockInteractor obtainEventList]);
    OCMVerify([self.mockView setupViewWithEventList:OCMOCK_ANY]);
}

- (void)testSuccessDidTriggerTapCellWithEvent {
    // given
    MSMessage *message = [[MSMessage alloc] init];
    NSString *givenIdentifier = @"EventModelObject_42";
    message.URL = [NSURL URLWithString:givenIdentifier];
    NSExtensionContext *context = [NSExtensionContext new];
    OCMStub([self.mockInteractor isCorrectIdentifier:givenIdentifier]).andReturn(YES);

    // when
    [self.presenter didTapMessageWith:message
                 withExtensionContext:context];

    // then
    OCMVerify([self.mockRouter openEventModuleWithIdentifier:givenIdentifier
                                         andExtensionContext:context]);
}

- (void)testSuccessDidInsertMessage {
    // given
    NSString *objectId = @"123";
    EventPlainObject *event = [EventPlainObject new];
    event.eventId = objectId;

    // when
    [self.presenter didInsertNewMessageWithEvent:event];

    // then
    OCMVerify([self.mockView setupViewWithNewMessage:OCMOCK_ANY]);
}
@end
