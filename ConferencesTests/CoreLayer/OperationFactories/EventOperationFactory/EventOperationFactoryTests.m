//
//  EventOperationFactoryTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "CompoundOperationFactoryTestsBase.h"

#import "EventOperationFactory.h"
#import "Event.h"

@interface EventOperationFactoryTests : CompoundOperationFactoryTestsBase

@property (strong, nonatomic) InjectedClass(EventOperationFactory) factory;

@end

@implementation EventOperationFactoryTests

- (void)setUp {
    [super setUp];
    
    self.requestName = @"Event";
    self.requestSuffix = @"/Event";
}

- (void)tearDown {
    self.factory = nil;
    
    [super tearDown];
}

- (void)testGetEventsOperation {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    [self setupTestOperation];
    
    // when
    CompoundOperationBase *operation = [self.factory getEventsOperationWithQuery:nil];
    
    // then
    [self testCompoundOperation:operation expectation:expectation expectationBlock:^(NSArray *resultData, NSError *resultError) {
        id firstObject = [resultData firstObject];
        
        XCTAssertNotNil(resultData);
        XCTAssertNil(resultError);
        XCTAssertEqual(resultData.count, 2);
        XCTAssertTrue([firstObject isKindOfClass:[Event class]]);
    }];
    
}

#pragma mark - Network stubs setup

- (void)setupTestOperation {
    MMBarricadeResponse *successResponse = [MMBarricadeResponse responseWithName:@"Success"
                                                                            file:[self pathForResponseWithName:@"success.json"]
                                                                      statusCode:200
                                                                     contentType:@"application/json"];
    [self configureNetworkStubsWithResponses:@[successResponse]
                                 requestName:self.requestName
                           requestPathSuffix:self.requestSuffix];
}

@end
