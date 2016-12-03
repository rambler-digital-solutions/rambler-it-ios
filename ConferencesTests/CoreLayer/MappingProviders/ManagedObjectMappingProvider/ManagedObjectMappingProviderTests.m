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
#import <OCMock/OCMock.h>
#import <EasyMapping/EasyMapping.h>

#import "ManagedObjectMappingProvider.h"
#import "EntityNameFormatter.h"
#import "SocialNetworkAccountModelObject.h"

@interface ManagedObjectMappingProviderTests : XCTestCase

@property (nonatomic, strong) ManagedObjectMappingProvider *provider;
@property (nonatomic, strong) id mockEntityNameFormatter;

@end

@implementation ManagedObjectMappingProviderTests

- (void)setUp {
    [super setUp];
    
    self.provider = [[ManagedObjectMappingProvider alloc] init];
    self.mockEntityNameFormatter = OCMProtocolMock(@protocol(EntityNameFormatter));
    self.provider.entityNameFormatter = self.mockEntityNameFormatter;
}

- (void)tearDown {
    self.provider = nil;
    self.mockEntityNameFormatter = nil;
    
    [super tearDown];
}

- (void)testThatProviderReturnsProperMappingForOneOfModels {
    // given
    Class targetClass = [SocialNetworkAccountModelObject class];
    NSString *const kExpectedEntityName = @"SocialNetworkAccount";
    OCMStub([self.mockEntityNameFormatter transformToEntityNameClass:targetClass]).andReturn(kExpectedEntityName);
    
    // when
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:targetClass];
    
    // then
    XCTAssertEqualObjects(mapping.entityName, kExpectedEntityName);
}

@end
