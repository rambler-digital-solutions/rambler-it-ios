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
#import <MagicalRecord/MagicalRecord.h>

#import "XCTestCase+RCFHelpers.h"

#import "FetchedResultsControllerChangeProvider.h"
#import "ChangeProviderFetchRequestFactory.h"
#import "ObjectTransformer.h"
#import "EventModelObject.h"
#import "ChangeProviderDelegate.h"

@interface FetchedResultsControllerChangeProviderTests : XCTestCase

@property (nonatomic, strong) FetchedResultsControllerChangeProvider *provider;
@property (nonatomic, strong) id mockRequestFactory;
@property (nonatomic, strong) id mockObjectTransformer;
@property (nonatomic, strong) id mockDelegate;

@end

@implementation FetchedResultsControllerChangeProviderTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.mockRequestFactory = OCMProtocolMock(@protocol(ChangeProviderFetchRequestFactory));
    self.mockObjectTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockDelegate = OCMProtocolMock(@protocol(ChangeProviderDelegate));
    
    self.provider = [FetchedResultsControllerChangeProvider changeProviderWithFetchRequestFactory:self.mockRequestFactory
                                                                                objectTransformer:self.mockObjectTransformer];
    self.provider.delegate = self.mockDelegate;
}

- (void)tearDown {
    self.provider = nil;
    
    self.mockRequestFactory = nil;
    self.mockObjectTransformer = nil;
    self.mockDelegate = nil;
    
    [self tearDownCoreDataStack];
    
    [super tearDown];
}

- (void)testThatProviderAsksForFetchRequestOnMonitoringStart {
    // given
    [self stubRequestFactory];
    
    // when
    [self.provider startMonitoring];
    
    // then
    OCMVerify([self.mockRequestFactory obtainFetchRequestForIndexing]);
}

- (void)testThatProviderProcessesObjectsForInitialIndexing {
    // given
    [self generateEventForTestPurposes];
    [self stubRequestFactory];
    [self.provider startMonitoring];
    
    // when
    __block NSString *result;
    [self.provider processObjectsForInitialIndexingWithBlock:^(NSString *objectType, NSString *objectIdentifier) {
        result = objectType;
    }];
    
    // then
    XCTAssertEqualObjects(result, NSStringFromClass([EventModelObject class]));
}

#pragma mark - Helper methods

- (void)stubRequestFactory {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES]];
    OCMStub([self.mockRequestFactory obtainFetchRequestForIndexing]).andReturn(request);
}

- (EventModelObject *)generateEventForTestPurposes {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_defaultContext];
    __block EventModelObject *event = nil;
    [rootSavingContext performBlockAndWait:^{
        event = [EventModelObject MR_createEntityInContext:rootSavingContext];
        event.startDate = [NSDate date];
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    return event;
}

@end
