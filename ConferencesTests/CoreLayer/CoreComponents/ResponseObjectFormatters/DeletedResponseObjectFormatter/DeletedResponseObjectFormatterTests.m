//
//  DeletedResponseObjectFormatterTests.m
//  Conferences
//
//  Created by k.zinovyev on 18.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DeletedResponseObjectFormatter.h"
#import "ModifiedDataListServerResponse.h"

@interface DeletedResponseObjectFormatterTests : XCTestCase

@property (strong, nonatomic) DeletedResponseObjectFormatter *formatter;

@end

@implementation DeletedResponseObjectFormatterTests

- (void)setUp {
    [super setUp];
    
    self.formatter = [[DeletedResponseObjectFormatter alloc] init];
}

- (void)tearDown {
    self.formatter = nil;
    
    [super tearDown];
}

- (void)testThatFormatterFormatsResponse {
    // given
    NSArray *resultsUpdated = @[@"1", @"2", @"3"];
    NSArray *resultsDeleted = @[@"4", @"5", @"6"];
    NSDictionary *response = @{
                               @"updated" : resultsUpdated,
                               @"deleted" : resultsDeleted
                               };
    NSUInteger const kExpectedNumberOfUpdatedItems = resultsUpdated.count;
    NSUInteger const kExpectedNumberOfDeletedItems = resultsDeleted.count;
    
    // when
    ModifiedDataListServerResponse *listResponse = [self.formatter formatServerResponse:response];
    
    // then
    XCTAssertTrue([listResponse.updatedObjects isKindOfClass:[NSArray class]]);
    XCTAssertEqual(listResponse.updatedObjects.count, kExpectedNumberOfUpdatedItems);
    XCTAssertTrue([listResponse.deletedObjects isKindOfClass:[NSArray class]]);
    XCTAssertEqual(listResponse.deletedObjects.count, kExpectedNumberOfDeletedItems);
    
}

@end
