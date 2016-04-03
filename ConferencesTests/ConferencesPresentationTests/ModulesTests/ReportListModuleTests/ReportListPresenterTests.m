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
