//
//  ResponseValidatorsAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 16/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerMcFlurry/Testing.h>

#import "ResponseValidatorsAssembly.h"
#import "ResponseValidatorsAssembly_Testable.h"
#import "ResponseValidatorsFactory.h"

#import "ParseResponseValidator.h"

@interface ResponseValidatorsAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ResponseValidatorsAssembly *assembly;

@end

@implementation ResponseValidatorsAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [ResponseValidatorsAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesParseResponseValidator {
    // given
    Class targetClass = [ParseResponseValidator class];
    
    // when
    id result = [self.assembly parseResponseValidator];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesValidatorWithResponseValidationParseType {
    // given
    Class targetClass = [ParseResponseValidator class];
    
    // when
    id result = [self.assembly validatorWithType:@(ResponseValidationParseType)];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
