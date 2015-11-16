//
//  EventListTableViewControllerTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "EventListTableViewController.h"
#import "EventListDataDisplayManager.h"
#import "EventListViewOutput.h"
#import "PlainEvent.h"

@interface EventListTableViewControllerTests : XCTestCase

@property (strong, nonatomic) EventListTableViewController <EventLIstDataDisplayManagerDelegate> *viewController;
@property (strong, nonatomic) EventListDataDisplayManager *mockDataDisplayManager;
@property (strong, nonatomic) id <EventListViewOutput> mockOutput;
@property (nonatomic, strong) UITableView *mockTableView;

@end

@implementation EventListTableViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [EventListTableViewController new];
    self.mockDataDisplayManager = OCMClassMock([EventListDataDisplayManager class]);
    self.mockOutput = OCMProtocolMock(@protocol(EventListViewOutput));
    self.mockTableView = OCMClassMock([UITableView class]);
    
    self.viewController.dataDisplayManager = self.mockDataDisplayManager;
    self.viewController.output = self.mockOutput;
    self.viewController.tableView = self.mockTableView;
}

- (void)tearDown {
    self.viewController = nil;
    self.mockDataDisplayManager = nil;
    self.mockOutput = nil;
    self.mockTableView = nil;
    
    [super tearDown];
}

#pragma mark - Lifecycle

- (void)testSuccessViewDidLoad {
    // given
    
    // when
    [self.viewController viewDidLoad];
    
    // then
    OCMVerify([self.mockOutput setupView]);
}

#pragma mark - EventListViewInput

- (void)testSuccessSetupViewWithEventList {
    // given
    NSArray *events = @[];
    
    id dataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    id delegate = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView]).andReturn(dataSource);
    OCMStub([self.mockDataDisplayManager delegateForTableView:self.mockTableView withBaseDelegate:nil]).andReturn(delegate);
    
    // when
    [self.viewController setupViewWithEventList:events];
    
    // then
    OCMVerify([self.mockTableView setDataSource:dataSource]);
    OCMVerify([self.mockTableView setDelegate:delegate]);
    OCMVerify([self.mockDataDisplayManager updateTableViewModelWithEvents:events]);
}

- (void)testSuccessUpdateViewWithEventList {
    // given
    NSArray *events = @[];
    
    // when
    [self.viewController updateViewWithEventList:events];
    
    // then
    OCMVerify([self.mockDataDisplayManager updateTableViewModelWithEvents:events]);
}

#pragma mark - EventLIstDataDisplayManagerDelegate

- (void)testSuccessDidUpdateTableViewModel {
    // given
    id dataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView]).andReturn(dataSource);
    
    // when
    [self.viewController didUpdateTableViewModel];
    
    // then
    OCMVerify([self.mockTableView setDataSource:dataSource]);
    OCMVerify([self.mockTableView reloadData]);
}

- (void)testSuccessDidTapCellWithEvent {
    // given
    PlainEvent *event = [PlainEvent new];
    
    // when
    [self.viewController didTapCellWithEvent:event];
    
    // then
    OCMVerify([self.mockOutput didTriggerTapCellWithEvent:event]);
}

@end
