//
//  RequestSignersAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 16/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "RequestSignersFactory.h"
#import "RequestSignersAssembly.h"
#import "ParseRequestSigner.h"

@interface RequestSignersAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) RequestSignersAssembly *assembly;

@end

@implementation RequestSignersAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [RequestSignersAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesParseRequestSigner {
    // given
    Class targetClass = [ParseRequestSigner class];
    NSArray *dependencies = @[
                              RamblerSelector(applicationId),
                              RamblerSelector(apiKey)
                              ];
    // when
    id result = [self.assembly requestSignerWithType:@(RequestSigningParseType)];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
