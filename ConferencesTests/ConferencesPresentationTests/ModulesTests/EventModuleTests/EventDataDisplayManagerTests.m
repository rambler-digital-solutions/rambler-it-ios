//
//  EventDataDisplayManagerTests.m
//  Conferences
//
//  Created by Karpushin Artem on 19/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "EventDataDisplayManager.h"
#import "EventCellObjectBuilderFactory.h"
#import "EventPlainObject.h"
#import "EventType.h"
#import "EventCellObjectBuilderBase.h"

@interface EventDataDisplayManagerTests : XCTestCase

@property (strong, nonatomic) EventDataDisplayManager *dataDisplayManager;

@end

@implementation EventDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    
    self.dataDisplayManager = [EventDataDisplayManager new];
}

- (void)tearDown {
    self.dataDisplayManager = nil;
    
    [super tearDown];
}

- (void)testSuccessConfigureDataDisplayManagerWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    EventCellObjectBuilderBase *mockCellObjectBuilder = OCMClassMock([EventCellObjectBuilderBase class]);
    EventCellObjectBuilderFactory *mockFactory = OCMClassMock([EventCellObjectBuilderFactory class]);
    OCMStub([mockFactory builderForEventType:OCMOCK_ANY]).andReturn(mockCellObjectBuilder);
    
    self.dataDisplayManager.cellObjectBuilderFactory = mockFactory;
    
    // when
    [self.dataDisplayManager configureDataDisplayManagerWithEvent:event];
    
    // then
    OCMVerify([mockCellObjectBuilder cellObjectsForEvent:event]);
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource{
    // given
    
    // when
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

@end
