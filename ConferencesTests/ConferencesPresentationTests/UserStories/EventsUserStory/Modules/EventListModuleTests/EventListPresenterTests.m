//
//  EventListPresenterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "EventListPresenter.h"
#import "EventListViewInput.h"
#import "EventListInteractorInput.h"
#import "EventListRouterInput.h"
#import "PlainEvent.h"

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
    PlainEvent *event = [PlainEvent new];
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
