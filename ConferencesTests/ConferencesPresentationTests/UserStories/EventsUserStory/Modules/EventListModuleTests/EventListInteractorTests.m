//
//  EventListInteractorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

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
