//
//  ResponseDeserializersAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 16/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerMcFlurry/Testing.h>

#import "ResponseDeserializersAssembly.h"
#import "ResponseDeserializersAssembly_Testable.h"
#import "ResponseDeserializersFactory.h"
#import "JSONResponseDeserializer.h"

@interface ResponseDeserializersAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ResponseDeserializersAssembly *assembly;

@end

@implementation ResponseDeserializersAssemblyTests

- (void)setUp {
    [super setUp];

    self.assembly = [ResponseDeserializersAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesDeserializerWithResponseDeserializationJSONType {
    // given
    Class targetClass = [JSONResponseDeserializer class];
    
    // when
    id restult = [self.assembly deserializerWithType:@(ResponseDeserializationJSONType)];
    
    // then
    [self verifyTargetDependency:restult withClass:targetClass];
}

- (void)testThatAssemblyCreatesJsonResponseDeserializer {
    // given
    Class targetClass = [JSONResponseDeserializer class];
    
    // when
    id result = [self.assembly jsonResponseDeserializer];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
