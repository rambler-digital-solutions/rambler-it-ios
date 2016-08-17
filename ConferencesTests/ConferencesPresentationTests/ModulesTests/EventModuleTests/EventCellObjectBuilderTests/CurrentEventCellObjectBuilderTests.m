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

#import "CurrentEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "CurrentVideoTranslationTableViewCellObject.h"
#import "EventPlainObject.h"
#import "DateFormatter.h"

@interface CurrentEventCellObjectBuilderTests : XCTestCase

@property (strong, nonatomic) CurrentEventCellObjectBuilder *cellObjectBuilder;
@property (strong, nonatomic) id mockDateFormatter;

@end

@implementation CurrentEventCellObjectBuilderTests

- (void)setUp {
    [super setUp];
    
    self.cellObjectBuilder = [CurrentEventCellObjectBuilder new];
    self.mockDateFormatter = OCMClassMock([DateFormatter class]);
    
    self.cellObjectBuilder.dateFormatter = self.mockDateFormatter;
}

- (void)tearDown {
    self.cellObjectBuilder = nil;
    
    [self.mockDateFormatter stopMocking];
    self.mockDateFormatter = nil;

    [super tearDown];
}

- (void)testThatBuilderCreatesCorrectCellObjects {
    // given
    NSUInteger const expectedNumberOfEventInfoTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfCurrentVideoTranslationTableViewCellObjects = 1;
    NSUInteger actualNumberOfEventInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfCurrentVideoTranslationTableViewCellObjects = 0;
    
    NSDate *eventStartDate = [NSDate date];
    
    EventPlainObject *event = [EventPlainObject new];
    event.startDate = eventStartDate;
    
    // when
    NSArray *cellObjects = [self.cellObjectBuilder cellObjectsForEvent:event pastEvents:nil];
    
    for (id cellObject in cellObjects) {
        if ([cellObject isKindOfClass:[EventInfoTableViewCellObject class]]) {
            actualNumberOfEventInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[CurrentVideoTranslationTableViewCellObject class]]) {
            actualNumberOfCurrentVideoTranslationTableViewCellObjects++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfEventInfoTableViewCellObjects, actualNumberOfEventInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfCurrentVideoTranslationTableViewCellObjects, actualNumberOfCurrentVideoTranslationTableViewCellObjects);
    OCMVerify([self.mockDateFormatter obtainDateWithDayMonthYearTimeFormat:eventStartDate]);
}

@end
