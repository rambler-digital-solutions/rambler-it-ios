//
//  ReportListPresenterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ReportListPresenter.h"
#import "ReportListViewInput.h"
#import "ReportListInteractorInput.h"
#import "ReportListRouterInput.h"
#import "EventPlainObject.h"

@interface ReportListPresenterTests : XCTestCase

@property (strong, nonatomic) ReportListPresenter *presenter;
@property (strong, nonatomic) id <ReportListInteractorInput> mockInteractor;
@property (strong, nonatomic) id <ReportListViewInput> mockView;
@property (strong, nonatomic) id <ReportListRouterInput> mockRouter;

@end

@implementation ReportListPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [ReportListPresenter new];
    self.mockInteractor = OCMProtocolMock(@protocol(ReportListInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(ReportListViewInput));
    self.mockRouter = OCMProtocolMock(@protocol(ReportListRouterInput));
    
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
    NSString *eventId = @"123";
    EventPlainObject *event = [EventPlainObject new];
    event.eventId = eventId;
    
    // when
    [self.presenter didTriggerTapCellWithEvent:event];
    
    // then
    OCMVerify([self.mockRouter openEventModuleWithEventObjectId:eventId]);
}

- (void)testCorrectSearchBarChangedWithNilText {
    // given
    NSArray *events = @[];
    OCMStub([self.mockInteractor obtainEventListWithPredicate:nil]).andReturn(events);
    // when
    [self.presenter didSearchBarChangedWithText:nil];
    
    // then
    OCMVerify([self.mockInteractor obtainEventListWithPredicate:nil]);
    OCMVerify([self.mockView updateViewWithEventList:events]);
}

- (void)testCorrectSearchBarChangedWithEmptyText {
    // given
    NSArray *events = @[];
    OCMStub([self.mockInteractor obtainEventListWithPredicate:nil]).andReturn(events);
    // when
    [self.presenter didSearchBarChangedWithText:@""];
    
    // then
    OCMVerify([self.mockInteractor obtainEventListWithPredicate:nil]);
    OCMVerify([self.mockView updateViewWithEventList:events]);
}

- (void)testCorrectSearchBarChangedWithText {
    // given
//    NSArray *events = @[];
    OCMStub([self.mockInteractor obtainEventListWithPredicate:nil]).andReturn(nil);
    // when
    [self.presenter didSearchBarChangedWithText:@"ext"];
    
    // then
    OCMVerify([self.mockInteractor obtainEventListWithPredicate:OCMOCK_ANY]);
    OCMVerify([self.mockView updateViewWithEventList:nil]);
}

@end
