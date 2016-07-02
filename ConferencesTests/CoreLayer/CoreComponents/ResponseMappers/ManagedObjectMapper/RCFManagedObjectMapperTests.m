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
#import <MagicalRecord/MagicalRecord.h>

#import "ManagedObjectMapper.h"
#import "ManagedObjectMappingProvider.h"
#import "ResultsResponseObjectFormatter.h"
#import "EntityNameFormatterImplementation.h"

#import "SocialNetworkAccountManagedObject.h"
#import "NetworkingConstantsHeader.h"

@interface RCFManagedObjectMapperTests : XCTestCase

@property (strong, nonatomic) ManagedObjectMapper *mapper;

@end

@implementation RCFManagedObjectMapperTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    ManagedObjectMappingProvider *provider = [[ManagedObjectMappingProvider alloc] init];
    ResultsResponseObjectFormatter *formatter = [[ResultsResponseObjectFormatter alloc] init];
    EntityNameFormatterImplementation *entityFormatter = [[EntityNameFormatterImplementation alloc] init];
    self.mapper = [[ManagedObjectMapper alloc] initWithMappingProvider:provider
                                                  responseObjectFormatter:formatter
                                                   entityNameFormatter:entityFormatter];
}

- (void)tearDown {
    self.mapper = nil;
    
    [MagicalRecord cleanUp];
    
    [super tearDown];
}

- (void)testThatMapperMapsSocialNetworkAccount {
    // given
    Class targetClass = [SocialNetworkAccountManagedObject class];
    NSDictionary *serverResponse = [self generateServerResponseForModelClass:targetClass];
    NSDictionary *mappingContext = [self generateMappingContextForModelClass:targetClass];
    
    // when
    NSArray *result = [self.mapper mapServerResponse:serverResponse
                                  withMappingContext:mappingContext
                                               error:nil];
    id firstObject = [result firstObject];
    
    // then
    XCTAssertEqual(result.count, 1);
    XCTAssertTrue([firstObject isKindOfClass:targetClass]);
    XCTAssertNotNil([firstObject objectId]);
    XCTAssertNotNil([firstObject name]);
    XCTAssertNotNil([firstObject profileLink]);
}

#pragma mark - Helper Methods

- (NSDictionary *)generateMappingContextForModelClass:(Class)modelClass {
    NSString *className = NSStringFromClass(modelClass);
    return @{
             kMappingContextModelClassKey : className
             };
}

- (NSDictionary *)generateServerResponseForModelClass:(Class)modelClass {
    Class testCaseClass = [self class];
    
    NSString *bundleName = NSStringFromClass(testCaseClass);
    NSString *modelName = NSStringFromClass(modelClass);
    NSString *fileName = [NSString stringWithFormat:@"%@.json", modelName];
    
    NSBundle *resourceBundle = [NSBundle bundleForClass:testCaseClass];
    
    NSString *pathToTestBundle = [resourceBundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *testBundle = [NSBundle bundleWithPath:pathToTestBundle];
    
    NSString *pathToFile = [[testBundle resourcePath] stringByAppendingPathComponent:fileName];
    NSData *responseData = [NSData dataWithContentsOfFile:pathToFile
                                                  options:0
                                                    error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:nil];
    
    return json;
}

@end
