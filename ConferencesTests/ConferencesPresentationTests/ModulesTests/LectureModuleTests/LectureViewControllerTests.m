// Copyright (c) 2016 RAMBLER&Co
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
}

- (void)testSuccessConfigureViewWithLecture {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    // when
    [self.viewController configureViewWithLecture:lecture];
    
    // then
    OCMVerify([self.dataDisplayManagerMock configureDataDisplayManagerWithLecture:lecture]);
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
    [self.viewController didTapShareButton:nil];
    
    // then
    OCMVerify([self.presenterMock didTapShareButton]);
}

- (void)testSuccessDidTapVideoPreview {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    
    // when
    [self.viewController didTapVideoRecordCellWithVideoUrl:testUrl];
    
    // then
    OCMVerify([self.presenterMock didTapVideoPreviewWithUrl:testUrl]);
}

- (void)testSuccessDidTapMaterialPreview {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    
    // when
    [self.viewController didTapMaterialCellWithUrl:testUrl];
    
    // then
    OCMVerify([self.presenterMock didTapMaterialWithUrl:testUrl]);
}

@end
