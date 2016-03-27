//
//  SpeakerInfoViewControllerTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "SpeakerInfoViewController.h"
#import "SpeakerInfoViewOutput.h"
#import "SpeakerInfoDataDisplayManager.h"
#import "SpeakerPlainObject.h"
#import "SpeakerShortInfoModuleInput.h"
#import "SpeakerShortInfoView.h"

static CGFloat TableViewEstimatedRowHeight = 44.0f;

@interface SpeakerInfoViewControllerTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoViewController *viewController;
@property (nonatomic, strong) SpeakerInfoDataDisplayManager *dataDisplayManagerMock;
@property (nonatomic, strong) UITableView *tableViewMock;

@end

@implementation SpeakerInfoViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [SpeakerInfoViewController new];
    self.dataDisplayManagerMock = OCMClassMock([SpeakerInfoDataDisplayManager class]);
    self.tableViewMock = OCMClassMock([UITableView class]);
    
    self.viewController.dataDisplayManager = self.dataDisplayManagerMock;
    self.viewController.tableView = self.tableViewMock;
}

- (void)tearDown {
    self.viewController = nil;
    
    [(id)self.dataDisplayManagerMock stopMocking];
    self.dataDisplayManagerMock = nil;
    [(id)self.tableViewMock stopMocking];
    self.tableViewMock = nil;
    
    [super tearDown];
}

#pragma mark - Lifecycle

- (void)testSuccessViewDidLoad {
    // given
    id presenterMock = OCMProtocolMock(@protocol(SpeakerInfoViewOutput));
    self.viewController.output = presenterMock;
    
    // when
    [self.viewController viewDidLoad];
    
    // then
    OCMVerify([presenterMock setupView]);
}

#pragma mark - SpeakerInfoViewInput

- (void)testSuccessSetupTableViewDataSource {
    // given
    id dataSourceMock = OCMProtocolMock(@protocol(UITableViewDataSource));
    
    OCMStub([self.dataDisplayManagerMock dataSourceForTableView:OCMOCK_ANY]).andReturn(dataSourceMock);
    
    // when
    [self.viewController setupViewWithSpeaker:OCMOCK_ANY];
    
    // then
    OCMVerify([self.tableViewMock setDataSource:dataSourceMock]);
}

- (void)testSuccessSetupTableViewDelegate {
    // given
    id delegateMock = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.dataDisplayManagerMock delegateForTableView:OCMOCK_ANY withBaseDelegate:OCMOCK_ANY]).andReturn(delegateMock);
    
    // when
    [self.viewController setupViewWithSpeaker:OCMOCK_ANY];
    
    // then
    OCMVerify([self.tableViewMock setDelegate:delegateMock]);
}

- (void)testSuccessSetupTableView {
    // given
    UITableView *tableView = [UITableView new];
    self.viewController.tableView = tableView;
    
    // when
    [self.viewController setupViewWithSpeaker:OCMOCK_ANY];
    
    // then
    XCTAssert(tableView.estimatedRowHeight == TableViewEstimatedRowHeight);
    XCTAssert(tableView.rowHeight == UITableViewAutomaticDimension);
    XCTAssertNotNil(tableView.tableFooterView);
}

- (void)testSuccessSetupHeaderView {
    // given
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    
    id speakerShortInfoViewMock = OCMClassMock([SpeakerShortInfoView class]);
    
    self.viewController.speakerShortInfoView = speakerShortInfoViewMock;
    
    // when
    [self.viewController setupViewWithSpeaker:speaker];
    
    // then
    OCMVerify([speakerShortInfoViewMock configureModuleWithSpeaker:speaker andViewSize:SpeakerShortInfoViewBigSize]);
}

@end
