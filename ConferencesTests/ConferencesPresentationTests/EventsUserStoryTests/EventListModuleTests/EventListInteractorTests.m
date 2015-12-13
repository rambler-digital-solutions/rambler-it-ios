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

#import "EventListInteractor.h"
#import "EventService.h"
#import "EventPrototypeMapper.h"
#import "PrototypeMapper.h"
#import "EventListInteractorOutput.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface EventListInteractorTests : XCTestCase

@property (strong, nonatomic) EventListInteractor *interactor;
@property (strong, nonatomic) id <EventService> mockEventService;
@property (strong, nonatomic) id <PrototypeMapper> mockPrototypeMapper;
@property (strong, nonatomic) id <EventListInteractorOutput> mockOutput;

@end

@implementation EventListInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [EventListInteractor new];
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockPrototypeMapper = OCMProtocolMock(@protocol(PrototypeMapper));
    self.mockOutput = OCMProtocolMock(@protocol(EventListInteractorOutput));
    
    self.interactor.eventService = self.mockEventService;
    self.interactor.eventPrototypeMapper = self.mockPrototypeMapper;
    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockEventService = nil;
    self.mockPrototypeMapper = nil;
    self.mockOutput = nil;
    
    [super tearDown];
}

- (void)testSuccessUpdateEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *data = @[event];
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation){
        void(^completionBlock)(id data, NSError *error);
        
        [invocation getArgument:&completionBlock atIndex:3];
        
        completionBlock(data, nil);
    };
    
    OCMStub([self.mockEventService updateEventWithPredicate:OCMOCK_ANY completionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    
    // when
    [self.interactor updateEventList];
    
    // then
    OCMVerify([self.mockPrototypeMapper fillObject:OCMOCK_ANY withObject:event]);
    OCMVerify([self.mockOutput didUpdateEventList:OCMOCK_ANY]);
}

- (void)testSuccessObtainEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *events = @[event];
    
    OCMStub([self.mockEventService obtainEventWithPredicate:nil]).andReturn(events);
    
    // when
    id result = [self.interactor obtainEventList];
    
    // then
    XCTAssertNotNil(result);
    OCMVerify([self.mockPrototypeMapper fillObject:OCMOCK_ANY withObject:event]);
}

@end
