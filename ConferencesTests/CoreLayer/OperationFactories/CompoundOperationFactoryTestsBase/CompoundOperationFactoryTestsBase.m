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

#import "CompoundOperationFactoryTestsBase.h"

#import "OperationFactoriesAssembly.h"
#import "RequestConfiguratorsAssembly.h"
#import "RequestSignersAssembly.h"
#import "NetworkClientsAssembly.h"
#import "ResponseDeserializersAssembly.h"
#import "ResponseValidatorsAssembly.h"
#import "ResponseMappersAssembly.h"

@implementation CompoundOperationFactoryTestsBase

#pragma mark - Initial state setup

- (void)setUp {
    [self setUpWithAdditionalCollaboratingAssemblies:nil];
}

- (void)setUpWithAdditionalCollaboratingAssemblies:(NSArray *)additionalCollaboratingAssemblies {
    [super setUp];
    
    OperationFactoriesAssembly *assembly = [OperationFactoriesAssembly new];
    NSArray *collaboratingAssemblies = @[
                                         [RequestConfiguratorsAssembly new],
                                         [RequestSignersAssembly new],
                                         [NetworkClientsAssembly new],
                                         [ResponseDeserializersAssembly new],
                                         [ResponseValidatorsAssembly new],
                                         [ResponseMappersAssembly new]
                                         ];
    
    if (additionalCollaboratingAssemblies) {
        collaboratingAssemblies = [collaboratingAssemblies arrayByAddingObjectsFromArray:additionalCollaboratingAssemblies];
    }
    
    [assembly activateWithCollaboratingAssemblies:collaboratingAssemblies];
    [assembly inject:self];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
}

- (void)tearDown {
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testCompoundOperation:(CompoundOperationBase *)compoundOperation
                  expectation:(XCTestExpectation *)expectation
             expectationBlock:(CompoundOperationFactoryExpectationBlock)block {
    __block id resultData = nil;
    __block NSError *resultError = nil;
    compoundOperation.resultBlock = ^void(id data, NSError *error) {
        resultData = data;
        resultError = error;
        [self fulfillExpectationInMainThread:expectation];
    };
    
    // when
    [compoundOperation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError *error) {
        block(resultData, resultError);
    }];
}

- (void)configureNetworkStubsWithResponses:(NSArray *)responses
                               requestName:(NSString *)requestName
                         requestPathSuffix:(NSString *)suffix {
    [MMBarricade setupWithInMemoryResponseStore];
    [MMBarricade enable];
    
    self.requestName = requestName;
    MMBarricadeResponseSet *responseSet = [MMBarricadeResponseSet responseSetForRequestName:self.requestName respondsToRequest:^BOOL(NSURLRequest *request, NSURLComponents *components) {
        return [components.path rangeOfString:suffix].location != NSNotFound;
    }];
    
    for (MMBarricadeResponse *response in responses) {
        [responseSet addResponse:response];
    }
    
    [MMBarricade registerResponseSet:responseSet];
}

- (NSString *)pathForResponseWithName:(NSString *)name {
    SEL testSelector = self.invocation.selector;
    Class testCaseClass = [self class];
    
    NSString *bundleName = NSStringFromClass(testCaseClass);
    NSString *subpath = NSStringFromSelector(testSelector);
    
    NSBundle *resourceBundle = [NSBundle bundleForClass:testCaseClass];
    
    NSString *pathToTestBundle = [resourceBundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *testBundle = [NSBundle bundleWithPath:pathToTestBundle];
    
    NSString *pathToFolder = [[testBundle resourcePath] stringByAppendingPathComponent:subpath];
    NSString *pathToFile = [pathToFolder stringByAppendingPathComponent:name];
    
    return pathToFile;
}

@end
