//
//  ReportListTableViewControllerTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ReportListTableViewController.h"
#import "ReportListViewOutput.h"
#import "DataDisplayManager.h"
#import "ReportListDataDisplayManager.h"
#import "PlainEvent.h"

@interface ReportListTableViewControllerTests : XCTestCase

@property (strong, nonatomic) ReportListTableViewController <ReportListDataDisplayManagerDelegate> *viewController;
@property (strong, nonatomic) ReportListDataDisplayManager *mockDataDisplayManager;
@property (strong, nonatomic) id <ReportListViewOutput> mockOutput;
@property (strong, nonatomic) UITableView *mockTableView;

@end

@implementation ReportListTableViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [ReportListTableViewController new];
    self.mockDataDisplayManager = OCMClassMock([ReportListDataDisplayManager class]);
    self.mockOutput = OCMProtocolMock(@protocol(ReportListViewOutput));
    self.mockTableView = OCMClassMock([UITableView class]);
    
    self.viewController.dataDisplayManager = self.mockDataDisplayManager;
    self.viewController.output = self.mockOutput;
    self.viewController.tableView = self.mockTableView;
}

- (void)tearDown {
    self.viewController = nil;
    [(id)self.mockDataDisplayManager stopMocking];
    self.mockDataDisplayManager = nil;
    [(id)self.mockOutput stopMocking];
    self.mockOutput = nil;
    [(id)self.mockTableView stopMocking];
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

#pragma mark - ReportListViewInput

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

#pragma mark - ReportListDataDisplayManagerDelegate

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
