//
//  EventPresenterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 05/12/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "EventPresenter.h"
#import "EventInteractorInput.h"
#import "EventViewInput.h"
#import "EventPresenterStateStorage.h"
#import "EventPlainObject.h"
#import "EventRouterInput.h"
#import "LocalizedStrings.h"

@interface EventPresenterTests : XCTestCase

@property (strong, nonatomic) EventPresenter *presenter;
@property (strong, nonatomic) id <EventInteractorInput> interactorMock;
@property (strong, nonatomic) id <EventViewInput> viewMock;
@property (strong, nonatomic) EventPresenterStateStorage *presenterStateStorage;
@property (strong, nonatomic) id routerMock;

@end

@implementation EventPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [EventPresenter new];
    self.interactorMock = OCMProtocolMock(@protocol(EventInteractorInput));
    self.viewMock = OCMProtocolMock(@protocol(EventViewInput));
    self.presenterStateStorage = [EventPresenterStateStorage new];
    self.routerMock = OCMProtocolMock(@protocol(EventRouterInput));
    
    self.presenter.interactor = self.interactorMock;
    self.presenter.view = self.viewMock;
    self.presenter.presenterStateStorage = self.presenterStateStorage;
    self.presenter.router = self.routerMock;
}

- (void)tearDown {
    self.presenter = nil;
    self.presenterStateStorage = nil;
    [(id)self.interactorMock stopMocking];
    self.interactorMock = nil;
    [(id)self.viewMock stopMocking];
    self.viewMock = nil;
    [self.routerMock stopMocking];
    self.routerMock = nil;
    
    [super tearDown];
}

#pragma mark - EventModuleInput

- (void)testSuccessConfigureCurrentModuleWithEventObjectId {
    // given
    NSString *eventObjectId = @"Ds312k7";
    
    // when
    [self.presenter configureCurrentModuleWithEventObjectId:eventObjectId];
    
    // then
    XCTAssertEqualObjects(eventObjectId, self.presenterStateStorage.eventObjectId);
}

#pragma mark - EventViewOutput

- (void)testSuccessSetupView {
    // given
    NSString *eventObjectId = @"Ds312k7";
    
    // when
    [self.presenter configureCurrentModuleWithEventObjectId:eventObjectId];
    [self.presenter setupView];
    
    // then
    OCMVerify([self.interactorMock obtainEventWithObjectId:eventObjectId]);
}

- (void)testSuccesDidTapSignUpButtonWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.presenter didTapSignUpButtonWithEvent:event];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidTapSaveToCalendarButtonWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.presenter didTapSaveToCalendarButtonWithEvent:event];
    
    // then
    OCMVerify([self.interactorMock saveEventToCalendar:event]);
}

- (void)testSuccessDidTapReadMoreEventDescriptionButton {
    // given
    
    // when
    [self.presenter didTapReadMoreEventDescriptionButton];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidTapReadMoreLectureDescriptionButton {
    // given
    
    // when
    [self.presenter didTapReadMoreLectureDescriptionButton];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidTapCurrentTranslationButton {
    // given
    
    // when
    [self.presenter didTapCurrentTranslationButton];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidTapLectureInfoCellWithLectureObjectIdEvent {
    // given
    NSString *objectId = @"8hefw8";
    
    // when
    [self.presenter didTapLectureInfoCellWithLectureObjectIdEvent:objectId];
    
    // then
    OCMVerify([self.routerMock openLectureModuleWithLectureObjectId:objectId]);
}

#pragma mark - EventInteractorOutput

- (void)testSuccessDidObtainEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.presenter didObtainEvent:event];
    
    // then
    OCMVerify([self.viewMock configureViewWithEvent:event]);
}

- (void)testSuccessDidSaveEventToCalendarWithError {
    // given
    NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    NSString *alertTitle = NSLocalizedString(ErrorAlertTitle, nil);
    NSString *alertMessage = NSLocalizedString(EventAlreadyStoredInCalendarErrorDescription, nil);
    
    // when
    [self.presenter didSaveEventToCalendarWithError:error];
    
    // then
    OCMVerify([self.viewMock displayAlertWithTitle:alertTitle andMessage:alertMessage]);
}

- (void)testSuccessDidSaveEventToCalendarWithoutError {
    // given
    NSError *error = nil;
    NSString *alertTitle = NSLocalizedString(EmptyAlertTitle, nil);
    NSString *alertMessage = NSLocalizedString(EventSavedToCalendarAlertMessage, nil);
    
    // when
    [self.presenter didSaveEventToCalendarWithError:error];
    
    // then
    OCMVerify([self.viewMock displayAlertWithTitle:alertTitle andMessage:alertMessage]);
}

@end
