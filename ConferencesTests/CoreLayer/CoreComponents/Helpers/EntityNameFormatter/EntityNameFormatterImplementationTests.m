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

#import "EntityNameFormatterImplementation.h"
#import "EventModelObject.h"

@interface EntityNameFormatterImplementationTests : XCTestCase

@property (nonatomic, strong) EntityNameFormatterImplementation *formatter;

@end

@implementation EntityNameFormatterImplementationTests

- (void)setUp {
    [super setUp];
    
    self.formatter = [EntityNameFormatterImplementation new];
}

- (void)tearDown {
    self.formatter = nil;
    
    [super tearDown];
}

- (void)testThatFormatterTransformsEntityNameToClass {
    // given
    NSString *testEntityName = @"Event";
    Class const kExpectedEntityClass = [EventModelObject class];
    
    // when
    Class result = [self.formatter transformToClassEntityName:testEntityName];
    
    // then
    XCTAssertEqual(result, kExpectedEntityClass);
}

- (void)testThatFormatterTransformsEntityClassToName {
    // given
    Class testEntityClass = [EventModelObject class];
    NSString *const kExpectedEntityName = @"Event";
    
    // when
    NSString *result = [self.formatter transformToEntityNameClass:testEntityClass];
    
    // then
    XCTAssertEqualObjects(result, kExpectedEntityName);
}

@end
