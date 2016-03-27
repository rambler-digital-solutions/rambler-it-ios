//
//  SpeakerInfoPresenterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "SpeakerInfoPresenter.h"
#import "SpeakerInfoViewInput.h"
#import "SpeakerInfoInteractorInput.h"
#import "SpeakerInfoPresenterStateStorage.h"
#import "SpeakerPlainObject.h"

@interface SpeakerInfoPresenterTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoPresenter *presenter;
@property (nonatomic, strong) id interactorMock;
@property (nonatomic, strong) id viewMock;

@end

@implementation SpeakerInfoPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [SpeakerInfoPresenter new];
    self.interactorMock = OCMProtocolMock(@protocol(SpeakerInfoInteractorInput));
    self.viewMock = OCMProtocolMock(@protocol(SpeakerInfoViewInput));
    
    self.presenter.view = self.viewMock;
    self.presenter.interactor = self.interactorMock;
}

- (void)tearDown {
    self.presenter = nil;
    [self.interactorMock stopMocking];
    self.interactorMock = nil;
    [self.viewMock stopMocking];
    self.viewMock = nil;
    
    [super tearDown];
}

#pragma mark - SpeakerInfoViewOutput

- (void)testSuccessSetupview {
    // gvien
    NSString *speakerObjectId = @"23jk3";
    
    SpeakerInfoPresenterStateStorage *stateStorage = [SpeakerInfoPresenterStateStorage new];
    stateStorage.speakerObjectId = speakerObjectId;
    
    self.presenter.stateStorage = stateStorage;
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerify([self.interactorMock obtainSpeakerWithObjectId:speakerObjectId]);
}

#pragma mark - SpeakerInfoInteractorOutput

- (void)testSuccessDidObtainSpeaker {
    // given
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    
    // when
    [self.presenter didObtainSpeaker:speaker];
    
    // then
    OCMVerify([self.viewMock setupViewWithSpeaker:speaker]);
}

#pragma mark - SpeakerInfoModuleInput

- (void)testSuccessConfigureCurrentModuleWithSpeakerObjectId {
    // given
    NSString *speakerObjectId = @"23jk3";
    
    SpeakerInfoPresenterStateStorage *stateStorage = [SpeakerInfoPresenterStateStorage new];
    self.presenter.stateStorage = stateStorage;
    
    // when
    [self.presenter configureCurrentModuleWithSpeakerObjectId:speakerObjectId];
    
    // then
    XCTAssert(stateStorage.speakerObjectId == speakerObjectId);
}

@end
