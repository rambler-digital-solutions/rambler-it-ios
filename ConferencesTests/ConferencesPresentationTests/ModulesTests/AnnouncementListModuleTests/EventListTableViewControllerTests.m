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

#import "EventListTableViewController.h"
#import "EventListDataDisplayManager.h"
#import "EventListViewOutput.h"
#import "EventPlainObject.h"

@interface EventListTableViewControllerTests : XCTestCase

@property (strong, nonatomic) EventListTableViewController <EventListDataDisplayManagerDelegate> *viewController;
@property (strong, nonatomic) id mockDataDisplayManager;
@property (strong, nonatomic) id <EventListViewOutput> mockOutput;
@property (strong, nonatomic) UITableView *mockTableView;

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

#pragma mark - EventListViewInput

- (void)testSuccessSetupTableViewDataSource {
    // given
    NSArray *events = @[];
    
    id mockDataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:OCMOCK_ANY]).andReturn(mockDataSource);
    
    // when
    [self.viewController setupViewWithEventList:events];
    
    // then
    OCMVerify([self.mockTableView setDataSource:mockDataSource]);
}

- (void)testSuccessSetupTableViewDelegate {
    // given
    NSArray *events = @[];
    
    id mockDelegate = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.mockDataDisplayManager delegateForTableView:OCMOCK_ANY withBaseDelegate:OCMOCK_ANY]).andReturn(mockDelegate);
    
    // when
    [self.viewController setupViewWithEventList:events];
    
    // then
    OCMVerify([self.mockTableView setDelegate:mockDelegate]);
}

- (void)testSuccessSetupViewWithEventList {
    // given
    NSArray *events = @[];
    
    id viewControllerPartialMock = OCMPartialMock(self.viewController);
    
    // when
    [self.viewController setupViewWithEventList:events];
    
    // then
    OCMVerify([viewControllerPartialMock updateViewWithEventList:events]);
    [(id)viewControllerPartialMock stopMocking];
    viewControllerPartialMock = nil;
}

- (BOOL)verifyViewControllerConfigureRightEvents:(NSArray *)events
                                    futureEvents:(NSArray *)futureEvents {
    for (id object in futureEvents) {
        if (![events containsObject:object]) {
            return NO;
        }
    }
    if ([futureEvents containsObject:events.firstObject]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - EventListDataDisplayManagerDelegate

- (void)testSuccessDidUpdateTableViewModel {
    // given

    // when
    [self.viewController didUpdateTableViewModel];
    
    // then
    OCMVerify([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView]);
    OCMVerify([self.mockTableView reloadData]);
}

- (void)testSuccessDidTapCellWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.viewController didTapCellWithEvent:event];
    
    // then
    OCMVerify([self.mockOutput didTriggerTapCellWithEvent:event]);
}

@end
