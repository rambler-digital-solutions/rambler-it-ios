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
@property (nonatomic, strong) id mockOutput;

@end

@implementation SpeakerInfoViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [SpeakerInfoViewController new];
    self.dataDisplayManagerMock = OCMClassMock([SpeakerInfoDataDisplayManager class]);
    self.tableViewMock = OCMClassMock([UITableView class]);
    self.mockOutput = OCMProtocolMock(@protocol(SpeakerInfoViewOutput));
    
    self.viewController.dataDisplayManager = self.dataDisplayManagerMock;
    self.viewController.tableView = self.tableViewMock;
    self.viewController.output = self.mockOutput;
}

- (void)tearDown {
    self.viewController = nil;
    
    self.mockOutput = nil;
    
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
    [speakerShortInfoViewMock stopMocking];
}

- (void)testSuccessDidTapSocialMaterial {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    
    // when
    [self.viewController didTapSocialMaterialCellWithUrl:testUrl];
    
    // then
    OCMVerify([self.mockOutput didTriggerSocialNetworkTapEventWithUrl:testUrl]);
}

- (void)testSuccessDidTapLecture {
    // given
    id mockLecture = [NSObject new];
    
    // when
    [self.viewController didTapLectureCellWithLecture:mockLecture];
    
    // then
    OCMVerify([self.mockOutput didTriggerLectureTapEventWithLecture:mockLecture]);
}

- (void)testSuccessDidTapShare {
    // given
    
    
    // when
    [self.viewController didTapShareButton:nil];
    
    // then
    OCMVerify([self.mockOutput didTriggerShareButtonTapEvent]);
}

@end
