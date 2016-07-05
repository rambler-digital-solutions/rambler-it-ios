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

#import "DirectionObjectMapper.h"
#import "DirectionObject.h"

@interface DirectionObjectMapperTests : XCTestCase

@property (nonatomic, strong) DirectionObjectMapper *mapper;

@end

@implementation DirectionObjectMapperTests

- (void)setUp {
    [super setUp];
    
    self.mapper = [DirectionObjectMapper new];
}

- (void)tearDown {
    self.mapper = nil;
    
    [super tearDown];
}

- (void)testThatMapperMapsResource {
    // given
    NSString *const kTestTitle = @"test-title";
    NSString *const kTestDescription = @"test-description";
    NSDictionary *const kTestDictionary = @{
                                            @"root" : @[
                                                        @{
                                                            @"title" : kTestTitle,
                                                            @"description" : kTestDescription
                                                            }
                                                    ]
                                            };
    
    // when
    NSArray *result = [self.mapper mapResource:kTestDictionary];
    DirectionObject *firstObject = [result firstObject];
    
    // then
    XCTAssertEqualObjects(firstObject.directionTitle, kTestTitle);
    XCTAssertEqualObjects(firstObject.directionDescription, kTestDescription);
}

@end
