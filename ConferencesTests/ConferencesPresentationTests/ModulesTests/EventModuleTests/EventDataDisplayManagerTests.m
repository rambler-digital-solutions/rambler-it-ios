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

#import "EventDataDisplayManager.h"
#import "EventCellObjectBuilderFactory.h"
#import "EventPlainObject.h"
#import "EventType.h"
#import "EventCellObjectBuilderBase.h"
#import "ModelObjectGenerator.h"

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
    EventPlainObject *event = [ModelObjectGenerator generateEventObjects:1].firstObject;
    NSArray *pastEvents = [ModelObjectGenerator generateEventObjects:3];
    
    id mockCellObjectBuilder = OCMClassMock([EventCellObjectBuilderBase class]);
    id mockFactory = OCMClassMock([EventCellObjectBuilderFactory class]);
    OCMStub([mockFactory builderForEventType:OCMOCK_ANY]).andReturn(mockCellObjectBuilder);
    
    self.dataDisplayManager.cellObjectBuilderFactory = mockFactory;
    
    // when
    [self.dataDisplayManager configureDataDisplayManagerWithEvent:event pastEvents:pastEvents];
    
    // then
    OCMVerify([mockCellObjectBuilder cellObjectsForEvent:event pastEvents:pastEvents]);
    [mockFactory stopMocking];
    [mockCellObjectBuilder stopMocking];
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource{
    // given
    
    // when
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

@end
