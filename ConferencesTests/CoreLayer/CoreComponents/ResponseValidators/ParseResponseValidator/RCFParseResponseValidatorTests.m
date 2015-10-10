//
//  ParseResponseValidatorTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFResponseValidatorTestsBase.h"

#import "ParseResponseValidator.h"

@interface RCFParseResponseValidatorTests : RCFResponseValidatorTestsBase

@property (strong, nonatomic) ParseResponseValidator *validator;

@end

@implementation RCFParseResponseValidatorTests

- (void)setUp {
    [super setUp];
    
    self.validator = [[ParseResponseValidator alloc] init];
}

- (void)tearDown {
    self.validator = nil;
    
    [super tearDown];
}

- (void)testThatValidatorValidatesCorrectObjectResponse {
    // given
    NSArray *validObjects = @[
                              @{
                                  @"score": @1337,
                                  @"playerName": @"Sean Plott",
                                  @"cheatMode": @NO,
                                  @"createdAt": @"2011-08-20T02:06:57.931Z",
                                  @"updatedAt": @"2011-08-20T02:06:57.931Z",
                                  @"objectId": @"Ed1nuqPvcm"
                                  }
                              ];
    
    // when
    
    // then
    [self verifyThatValidator:self.validator validatesCorrectResponse:validObjects];
}

- (void)testThatValidatorValidatesIncorrectObjectResponse {
    // given
    NSArray *invalidObjects = @[
                                @10,
                                @[@"1864"],
                                @{
                                    @"status" : @"OK",
                                    @"result" : @[
                                            @{@"id":@"1345",@"name":@"Mark"},
                                            @{@"id":@"1345",@"name":@"Mark"}
                                            ]
                                    }
                                ];
    
    // when
    
    // then
    [self verifyThatValidator:self.validator validatesIncorrectResponse:invalidObjects];
}

@end
