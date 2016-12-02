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

#import "EventPresenter.h"
#import "EventInteractorInput.h"
#import "EventViewInput.h"
#import "EventPresenterStateStorage.h"
#import "EventPlainObject.h"
#import "EventRouterInput.h"
#import "LocalizedStrings.h"
#import "ModelObjectGenerator.h"

@interface EventPresenterTests : XCTestCase

@property (nonatomic, strong) EventPresenter *presenter;
@property (nonatomic, strong) id <EventInteractorInput> interactorMock;
@property (nonatomic, strong) id <EventViewInput> viewMock;
@property (nonatomic, strong) EventPresenterStateStorage *presenterStateStorage;
@property (nonatomic, strong) id routerMock;

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
    EventPlainObject *event = [ModelObjectGenerator generateEventObjects:1].firstObject;
    NSArray *pastEvents = [ModelObjectGenerator generateEventObjects:3];
    OCMStub([self.interactorMock obtainEventWithObjectId:OCMOCK_ANY]).andReturn(event);
    OCMStub([self.interactorMock obtainPastEventsForEvent:OCMOCK_ANY]).andReturn(pastEvents);
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerify([self.viewMock configureViewWithEvent:event pastEvents:pastEvents]);
}

- (void)testSuccessDidTapSaveToCalendarButtonWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.presenter didTapSaveToCalendarButtonWithEvent:event];
    
    // then
    OCMVerify([self.interactorMock saveEventToCalendar:event]);
}

- (void)testSuccessDidTapLectureInfoCellWithLectureObjectIdEvent {
    // given
    NSString *objectId = @"8hefw8";
    
    // when
    [self.presenter didTapLectureInfoCellWithLectureObjectIdEvent:objectId];
    
    // then
    OCMVerify([self.routerMock openLectureModuleWithLectureObjectId:objectId]);
}

- (void)testSuccessDidTapEventCell {
    // given
    NSString *objectId = @"8hefw8";
    
    // when
    [self.presenter didTapEventCellWithEventId:objectId];
    
    // then
    OCMVerify([self.routerMock openEventModuleWithEventId:objectId]);
}

- (void)testSuccessDidTapShareButton {
    // given
    NSArray *activityItems = @[];
    EventPlainObject *event = [EventPlainObject new];
    
    OCMStub([self.interactorMock obtainEventWithObjectId:OCMOCK_ANY]).andReturn(event);
    OCMStub([self.interactorMock obtainActivityItemsForEvent:event]).andReturn(activityItems);
    
    // when
    [self.presenter didTapShareButton];
    
    // then
    OCMVerify([self.routerMock openShareModuleWithActivityItems:activityItems]);
}

#pragma mark - EventInteractorOutput

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
