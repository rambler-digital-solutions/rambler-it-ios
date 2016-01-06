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

#import "EventListPresenter.h"
#import "EventListViewInput.h"
#import "EventListInteractorInput.h"
#import "EventListRouterInput.h"
#import "EventPlainObject.h"

@interface EventListPresenterTests : XCTestCase

@property (strong, nonatomic) EventListPresenter *presenter;
@property (strong, nonatomic) id <EventListInteractorInput> mockInteractor;
@property (strong, nonatomic) id <EventListViewInput> mockView;
@property (strong, nonatomic) id <EventListRouterInput> mockRouter;

@end

@implementation EventListPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [EventListPresenter new];
    self.mockInteractor = OCMProtocolMock(@protocol(EventListInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(EventListViewInput));
    self.mockRouter = OCMProtocolMock(@protocol(EventListRouterInput));
    
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
    OCMVerify([self.mockInteractor updateEventList]);
    OCMVerify([self.mockView setupViewWithEventList:OCMOCK_ANY]);
}

- (void)testSuccessDidTriggerTapCellWithEvent {
    // given
    NSString *objectId = @"123";
    EventPlainObject *event = [EventPlainObject new];
    event.objectId = objectId;
    
    // when
    [self.presenter didTriggerTapCellWithEvent:event];
    
    // then
    OCMVerify([self.mockRouter openEventModuleWithEventObjectId:objectId]);
}

- (void)testSuccessDidUpdateEventList {
    // given
    NSArray *events = @[];
    
    // when
    [self.presenter didUpdateEventList:events];
    
    // then
    OCMVerify([self.mockView updateViewWithEventList:events]);
}

@end
