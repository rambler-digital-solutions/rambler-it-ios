//
//  LectureViewControllerTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "LectureViewController.h"
#import "LectureViewOutput.h"
#import "SpeakerShortInfoModuleInput.h"
#import "SpeakerShortInfoView.h"
#import "LectureDataDisplayManager.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"
#import "LectureViewController_Testable.h"

static CGFloat TableViewEstimatedRowHeight = 44.0f;

@interface LectureViewControllerTests : XCTestCase

@property (nonatomic, strong) LectureViewController *viewController;
@property (nonatomic, strong) LectureDataDisplayManager *dataDisplayManagerMock;
@property (nonatomic, strong) UITableView *tableViewMock;
@property (nonatomic, strong) id presenterMock;

@end

@implementation LectureViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [LectureViewController new];
    self.presenterMock = OCMProtocolMock(@protocol(LectureViewOutput));
    self.dataDisplayManagerMock = OCMClassMock([LectureDataDisplayManager class]);
    self.tableViewMock = OCMClassMock([UITableView class]);
    
    self.viewController.dataDisplayManager = self.dataDisplayManagerMock;
    self.viewController.tableView = self.tableViewMock;
    self.viewController.output = self.presenterMock;
}

- (void)tearDown {
    self.viewController = nil;
    [self.presenterMock stopMocking];
    self.presenterMock = nil;
    [(id)self.dataDisplayManagerMock stopMocking];
    self.dataDisplayManagerMock = nil;
    [(id)self.tableViewMock stopMocking];
    self.tableViewMock = nil;
    
    [super tearDown];
}

#pragma mark - Lifecycle methods

- (void)testSuccessViewDidLoad {
    // given
    
    // when
    [self.viewController viewDidLoad];
    
    // then
    OCMVerify([self.presenterMock setupView]);
}

#pragma mark - LectureViewInput

- (void)testSuccessSetupTableViewDataSource {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    id dataSourceMock = OCMProtocolMock(@protocol(UITableViewDataSource));
    
    OCMStub([self.dataDisplayManagerMock dataSourceForTableView:OCMOCK_ANY]).andReturn(dataSourceMock);
    
    // when
    [self.viewController configureViewWithLecture:lecture];
    
    // then
    OCMVerify([self.tableViewMock setDataSource:dataSourceMock]);
}

- (void)testSuccessSetupTableViewDelegate {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    id delegateMock = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.dataDisplayManagerMock delegateForTableView:OCMOCK_ANY withBaseDelegate:OCMOCK_ANY]).andReturn(delegateMock);
    
    // when
    [self.viewController configureViewWithLecture:lecture];
    
    // then
    OCMVerify([self.tableViewMock setDelegate:delegateMock]);
}

- (void)testSuccessSetupTableView {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    UITableView *tableView = [UITableView new];
    self.viewController.tableView = tableView;
    
    // when
    [self.viewController configureViewWithLecture:lecture];
    
    // then
    XCTAssert(tableView.estimatedRowHeight == TableViewEstimatedRowHeight);
    XCTAssert(tableView.rowHeight == UITableViewAutomaticDimension);
    XCTAssertNotNil(tableView.tableFooterView);
    XCTAssertNotNil(tableView.tableHeaderView.gestureRecognizers);
}

- (void)testSuccessConfigureViewWithLecture {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    // when
    [self.viewController configureViewWithLecture:lecture];
    
    // then
    OCMVerify([self.dataDisplayManagerMock configureDataDisplayManagerWithLecture:lecture]);
}

- (void)testSuccessSetupHeaderViewWithSpeaker {
    // given
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    LecturePlainObject *lecture = [LecturePlainObject new];
    lecture.speakers  = @[speaker];
    
    id speakerShortInfoViewMock = OCMClassMock([SpeakerShortInfoView class]);
    self.viewController.speakerShortInfoView = speakerShortInfoViewMock;
    
    // when
    [self.viewController configureViewWithLecture:lecture];
    
    // then
    OCMVerify([speakerShortInfoViewMock configureModuleWithSpeaker:speaker andViewSize:SpeakerShortInfoViewDefaultSize]);
}

#pragma mark - Actions

- (void)testSuccessDidTapTableViewHeader {
    // given
    
    // when
    [self.viewController didTapTableViewHeader];
    
    // then
    OCMVerify([self.presenterMock didTapTableViewHeader]);
}

- (void)testSuccessDidTapShareButton {
    // given
    
    // when
    [self.viewController didTapShareButton];
    
    // then
    OCMVerify([self.presenterMock didTapShareButton]);
}

@end
