//
//  ReportListInteractorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ReportListInteractor.h"
#import "ReportListInteractorOutput.h"

#import "EventService.h"
#import "EventTypeDeterminator.h"
#import "EventPrototypeMapper.h"
#import "EventPlainObject.h"
#import "EventModelObject.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface ReportListInteractorTests : XCTestCase

@property (strong, nonatomic) ReportListInteractor *interactor;
@property (strong, nonatomic) id mockEventTypeDeterminator;
@property (strong, nonatomic) id <ReportListInteractorOutput> mockOutput;
@property (strong, nonatomic) id <EventService> mockEventService;
@property (strong, nonatomic) id <PrototypeMapper> mockPrototypeMapper;

@end

@implementation ReportListInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [ReportListInteractor new];
    self.mockOutput = OCMProtocolMock(@protocol(ReportListInteractorOutput));
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockEventTypeDeterminator = OCMClassMock([EventTypeDeterminator class]);
    self.mockPrototypeMapper = OCMProtocolMock(@protocol(PrototypeMapper));
    
    self.interactor.output = self.mockOutput;
    self.interactor.eventService = self.mockEventService;
    self.interactor.eventTypeDeterminator = self.mockEventTypeDeterminator;
    self.interactor.eventPrototypeMapper = self.mockPrototypeMapper;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockOutput = nil;
    self.mockEventService = nil;
    
    [self.mockEventTypeDeterminator stopMocking];
    self.mockEventTypeDeterminator = nil;
    
    self.mockPrototypeMapper = nil;

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
    OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
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
    OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
}

@end
