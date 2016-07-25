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

#import "AnnouncementListInteractor.h"
#import "EventService.h"
#import "ROSPonsomizer.h"
#import "AnnouncementListInteractorOutput.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface AnnouncementListInteractorTests : XCTestCase

@property (strong, nonatomic) AnnouncementListInteractor *interactor;
@property (strong, nonatomic) id <EventService> mockEventService;
@property (strong, nonatomic) id <ROSPonsomizer> mockPonsomizer;
@property (strong, nonatomic) id <AnnouncementListInteractorOutput> mockOutput;

@end

@implementation AnnouncementListInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [AnnouncementListInteractor new];
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockOutput = OCMProtocolMock(@protocol(AnnouncementListInteractorOutput));
    
    self.interactor.eventService = self.mockEventService;
    self.interactor.output = self.mockOutput;
    self.interactor.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockEventService = nil;
    self.mockOutput = nil;
    self.mockPonsomizer = nil;
    
    [super tearDown];
}

- (void)testSuccessUpdateEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *data = @[event];
    NSArray *eventsPlainObjects = @[@1];
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation){
        void(^completionBlock)(id data, NSError *error);
        
        [invocation getArgument:&completionBlock atIndex:3];
        
        completionBlock(data, nil);
    };
    
    OCMStub([self.mockEventService updateEventWithPredicate:OCMOCK_ANY completionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    OCMStub([self.mockEventService obtainEventWithPredicate:nil]).andReturn(data);
    OCMStub([self.mockPonsomizer convertObject:data]).andReturn(eventsPlainObjects);
   
    // when
    [self.interactor updateEventList];
    
    // then
    OCMVerify([self.mockOutput didUpdateEventList:eventsPlainObjects]);
}

- (void)testSuccessObtainEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *eventsManagedObjects = @[event];
    NSArray *eventsPlainObjects = @[@1];
    
    OCMStub([self.mockEventService obtainEventWithPredicate:nil]).andReturn(eventsManagedObjects);
    OCMStub([self.mockPonsomizer convertObject:eventsManagedObjects]).andReturn(eventsPlainObjects);
    
    // when
    id result = [self.interactor obtainEventList];
    
    // then
    XCTAssertEqualObjects(result, eventsPlainObjects);
}

@end
