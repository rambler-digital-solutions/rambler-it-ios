//
//  LectureInteractorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "LectureInteractor.h"
#import "LectureInteractorOutput.h"

@interface LectureInteractorTests : XCTestCase

@property (nonatomic, strong) LectureInteractor *interactor;
@property (nonatomic, strong) id presenterMock;

@end

@implementation LectureInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [LectureInteractor new];
    self.presenterMock = OCMProtocolMock(@protocol(LectureInteractorOutput));
    
    self.interactor.output = self.presenterMock;
}

- (void)tearDown {
    self.interactor = nil;
    [self.presenterMock stopMocking];
    self.presenterMock = nil;
    
    [super tearDown];
}

#pragma mark - LectureInteractorInput

/**
 @author Artem Karpushin
 
 TODO: need to complete the test after service for lectures will get ready
 */
- (void)testSuccessObtainLectureWithObjectId {
    // given
    
    // when
    [self.interactor obtainLectureWithObjectId:OCMOCK_ANY];
    
    // then
    
}

@end
