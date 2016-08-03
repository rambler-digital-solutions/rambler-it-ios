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
#import "SpeakerInfoInteractorOutput.h"

@interface SpeakerInfoInteractorTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoInteractor *interactor;
@property (nonatomic, strong) id presenterMock;

@end

@implementation SpeakerInfoInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [SpeakerInfoInteractor new];
    self.presenterMock = OCMProtocolMock(@protocol(SpeakerInfoInteractorOutput));
    
    self.interactor.output = self.presenterMock;
}

- (void)tearDown {
    self.interactor = nil;
    
    [self.presenterMock stopMocking];
    self.presenterMock = nil;
    
    [super tearDown];
}

#pragma mark - SpeakerInfoInteractorInput

/**
 @author Artem Karpushin
 
 TODO: need to complete the test after service for speakers will get ready
 */
- (void)testSuccessObtainSpeakerWithObjectId {
    // given
    
    // when
    id result = [self.interactor obtainSpeakerWithSpeakerId:OCMOCK_ANY];
    
    // then
    XCTAssertNotNil(result);
}

@end
