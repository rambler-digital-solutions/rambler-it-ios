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
#import <Messages/Messages.h>

#import "MessagesPresenter.h"
#import "MessagesViewInput.h"
#import "MessagesInteractorInput.h"
#import "MessagesRouterInput.h"
#import "EventPlainObject.h"
#import "MockObjectsFactory.h"

@interface MessagesPresenterTests : XCTestCase

@property (nonatomic, strong) MessagesPresenter *presenter;
@property (nonatomic, strong) id <MessagesInteractorInput> mockInteractor;
@property (nonatomic, strong) id <MessagesViewInput> mockView;
@property (nonatomic, strong) id <MessagesRouterInput> mockRouter;

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
    if (@available(iOS 10, *)) {
        // given
        MSMessage *message = [[MSMessage alloc] init];
        NSString *givenIdentifier = [NSString stringWithFormat:[MockObjectsFactory eventModelObjectScheme], [MockObjectsFactory randomObjectIdentifier]];
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
}

- (void)testSuccessDidInsertMessage {
    // given
    NSString *objectId = [NSString stringWithFormat:[MockObjectsFactory eventModelObjectScheme], [MockObjectsFactory randomObjectIdentifier]];
    EventPlainObject *event = [EventPlainObject new];
    event.eventId = objectId;

    // when
    [self.presenter didInsertNewMessageWithEvent:event];

    // then
    OCMVerify([self.mockView setupViewWithNewMessage:OCMOCK_ANY]);
}
@end
