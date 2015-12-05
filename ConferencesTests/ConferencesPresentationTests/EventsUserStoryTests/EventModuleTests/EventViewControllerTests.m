//
//  EventViewControllerTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <CrutchKit/Proxying/Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h>

#import "EventViewController.h"
#import "EventViewOutput.h"
#import "EventDataDisplayManager.h"
#import "DataDisplayManager.h"
#import "EventTableViewCellActionProtocol.h"
#import "PlainEvent.h"

@interface EventViewControllerTests : XCTestCase

@property (strong, nonatomic) EventViewController <EventTableViewCellActionProtocol> *viewController;
@property (strong, nonatomic) id <EventViewOutput> mockOutput;
@property (strong, nonatomic) EventDataDisplayManager *mockDataDisplayManager;
@property (nonatomic, strong) UITableView *mockTableView;

@end

@implementation EventViewControllerTests

- (void)setUp {
    [super setUp];

    self.viewController = [EventViewController new];
    self.mockOutput = OCMProtocolMock(@protocol(EventViewOutput));
    self.mockDataDisplayManager = OCMClassMock([EventDataDisplayManager class]);
    self.mockTableView = OCMClassMock([UITableView class]);
    
    self.viewController.output = self.mockOutput;
    self.viewController.dataDisplayManager = self.mockDataDisplayManager;
    self.viewController.tableView = self.mockTableView;
}

- (void)tearDown {
    self.viewController = nil;
    self.mockOutput = nil;
    self.mockDataDisplayManager = nil;
    self.mockTableView = nil;
    
    [super tearDown];
}

#pragma mark - Lifecycle

- (void)testSuccessViewDidLoad {
    // given
    EventViewController *partialMockViewController = OCMPartialMock(self.viewController);
    
    // when
    [partialMockViewController viewDidLoad];
    
    // then
    OCMVerify([partialMockViewController cd_startObserveProtocol:@protocol(EventTableViewCellActionProtocol)]);
    OCMVerify([self.mockOutput setupView]);
}

#pragma mark - EventViewInput

- (void)testSuccessConfigureViewWithEvent {
    // given
    PlainEvent *event = [PlainEvent new];
    
    id dataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    id delegate = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView]).andReturn(dataSource);
    OCMStub([self.mockDataDisplayManager delegateForTableView:self.mockTableView withBaseDelegate:nil]).andReturn(delegate);
    
    // when
    [self.viewController configureViewWithEvent:event];
    
    // then
    OCMVerify([self.mockTableView setDataSource:dataSource]);
    OCMVerify([self.mockTableView setDelegate:delegate]);
    OCMVerify([self.mockDataDisplayManager configureDataDisplayManagerWithEvent:event]);
}

#pragma mark - EventTableViewCellActionProtocol

- (void)testSuccessDidTapSignUpButton {
    // given
    
    // when
    [self.viewController didTapSignUpButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerSignUpButtonTappedEvent]);
}

- (void)testSuccessdidTapSaveToCalendarButton {
    // given
    
    // when
    [self.viewController didTapSaveToCalendarButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerSaveToCalendarButtonTappedEvent]);
}

- (void)testSuccessDidTapReadMoreEventDescriptionButton {
    // given
    
    // when
    [self.viewController didTapReadMoreEventDescriptionButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerReadMoreEventDescriptionButtonTappedEvent]);
}

- (void)testSuccessDidTapReadMoreLectureDescriptionButton {
    // given
    
    // when
    [self.viewController didTapReadMoreLectureDescriptionButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerReadMoreLectureDescriptionButtonTappedEvent]);
}

- (void)testSuccessDidTapCurrentTranslationButton {
    // given
    
    // when
    [self.viewController didTapCurrentTranslationButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerCurrentTranslationButtonTapEvent]);
}

@end
