//
//  SpeakerInfoInteractorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "SpeakerInfoInteractor.h"
#import "ROSPonsomizer.h"
#import "SpeakerService.h"

@interface SpeakerInfoInteractorTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoInteractor *interactor;
@property (nonatomic, strong) id mockSpeakerService;
@property (nonatomic, strong) id mockPonsomizer;

@end

@implementation SpeakerInfoInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [SpeakerInfoInteractor new];
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockSpeakerService = OCMProtocolMock(@protocol(SpeakerService));
    
    self.interactor.speakerService = self.mockSpeakerService;
    self.interactor.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    self.interactor = nil;
    
    self.mockPonsomizer = nil;
    self.mockSpeakerService = nil;
    
    [super tearDown];
}

#pragma mark - SpeakerInfoInteractorInput

- (void)testSuccessObtainSpeakerWithObjectId {
    // given
    NSString *speakerId = @"test id";
    id speaker = [NSObject new];
    id plainSpeaker = [NSObject new];
    
    OCMStub([self.mockSpeakerService obtainSpeakerWithSpeakerId:speakerId]).andReturn(speaker);
    OCMStub([self.mockPonsomizer convertObject:speaker]).andReturn(plainSpeaker);
    
    // when
    id result = [self.interactor obtainSpeakerWithSpeakerId:speakerId];
    
    // then
    XCTAssertEqualObjects(result, plainSpeaker);
}

@end
