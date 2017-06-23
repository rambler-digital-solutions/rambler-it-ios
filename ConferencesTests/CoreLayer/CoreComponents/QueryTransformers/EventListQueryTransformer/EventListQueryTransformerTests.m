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

#import "EventListQueryTransformer.h"
#import "EventListQuery.h"

static NSString *const kLastModifiedFilterFormat = @"filter[modified_since]";

@interface EventListQueryTransformerTests : XCTestCase

@property (nonatomic, strong) EventListQueryTransformer *transformer;

@end

@implementation EventListQueryTransformerTests

- (void)setUp {
    [super setUp];
    
    self.transformer = [EventListQueryTransformer new];
}

- (void)tearDown {
    self.transformer = nil;
    
    [super tearDown];
}

- (void)testThatTransformerReturnsProperParametersForEmptyLastModified {
    // given
    EventListQuery *query = [EventListQuery new];
    
    // when
    NSDictionary *result = [self.transformer deriveUrlParametersFromQuery:query];
    
    // then
    XCTAssertTrue(result.allKeys.count == 0);
}

- (void)testThatTransformerReturnsProperParametersForNonNilLastModified {
    // given
    NSString *const kTestLastModified = @"000000";
    
    EventListQuery *query = [EventListQuery new];
    query.lastModifiedString = kTestLastModified;
    
    // when
    NSDictionary *result = [self.transformer deriveUrlParametersFromQuery:query];
    
    // then
    NSString *obtainedLastModified = [result objectForKey:kLastModifiedFilterFormat];
    XCTAssertEqualObjects(obtainedLastModified, kTestLastModified);
}

@end
