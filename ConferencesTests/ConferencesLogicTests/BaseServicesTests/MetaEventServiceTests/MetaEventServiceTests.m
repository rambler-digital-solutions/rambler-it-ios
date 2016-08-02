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
#import "MetaEventServiceImpementation.h"
#import "MetaEventModelObject.h"
#import <MagicalRecord/MagicalRecord.h>

@interface MetaEventServiceTests : XCTestCase

@property (nonatomic, strong) MetaEventServiceImpementation *metaEventService;

@end

@implementation MetaEventServiceTests

- (void)setUp {
    [super setUp];
    [MagicalRecord setDefaultModelFromClass:[self class]];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.metaEventService = [MetaEventServiceImpementation new];

}

- (void)tearDown {
    [MagicalRecord cleanUp];
    
    self.metaEventService = nil;
    [super tearDown];
}

- (void)testPerformanceExample {
    //given
    NSString *metaEventId = @"meta event test";
    [self generateMetaEventWithId:metaEventId];
    
    //when
    MetaEventModelObject *metaEvent = [self.metaEventService obtainMetaEventByMetaEventId:metaEventId];
    
    //then
    XCTAssertEqualObjects(metaEventId, metaEvent.metaEventId);
}


- (void)generateMetaEventWithId:(NSString *)metaEventId {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        MetaEventModelObject *metaEvent = [MetaEventModelObject MR_createEntityInContext:localContext];
        metaEvent.metaEventId = metaEventId;
        metaEvent.name = @"name";
    }];
}

@end
