//
//  ResponseConverterTests.m
//  Conferences
//
//  Created by k.zinovyev on 18.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ResponseConverterImplementation.h"
#import "ResponseObjectFormatter.h"
#import "ResultsResponseObjectFormatter.h"

@interface ResponseConverterTests : XCTestCase

@property (nonatomic, strong) ResponseConverterImplementation *converter;
@property (strong, nonatomic) id<ResponseObjectFormatter> mockResponseFormatter;

@end

@implementation ResponseConverterTests

- (void)setUp {
    [super setUp];
    
    self.converter = [[ResponseConverterImplementation alloc] init];
    self.mockResponseFormatter = [ResultsResponseObjectFormatter new];
    self.converter.responseFormatter = self.mockResponseFormatter;
}

- (void)tearDown {
    self.converter = nil;
    self.mockResponseFormatter = nil;
    [super tearDown];
}

- (void)testThatCorrectlyConvert {
    //given
    NSDictionary *inputData = [self inputJSONData];
    NSDictionary *outputData = [self outputJSONData];
    
    //when
    id result = [self.converter convertFromResponse:inputData];
    
    //then
    XCTAssertEqualObjects(result, outputData);
}

- (NSDictionary *)inputJSONData {
    return @{
             @"data" :
                 @[
                     @{
                         @"attributes" :
                            @{
                                @"name":@"1",
                                @"deleted":@1
                             }
                       },
                     @{
                         @"attributes" :
                            @{
                                @"name":@"2",
                                }
                       }
                    ]
             };
}

- (NSDictionary *)outputJSONData {
    return @{
             @"deleted" :
                 @[
                     @{
                         @"attributes" :
                             @{
                                 @"name":@"1",
                                 @"deleted":@1
                              }
                       }
                     ],
             
             @"updated" :
                 @[
                     @{
                         @"attributes" :
                             @{
                                 @"name":@"2",
                                 }
                       }
                     ]
             };
}

@end
