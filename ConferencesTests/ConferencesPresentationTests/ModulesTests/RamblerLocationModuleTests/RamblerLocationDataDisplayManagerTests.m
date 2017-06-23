//
//  RamblerLocationDataDisplayManagerTests.m
//  Conferences
//
//  Created by s.sarkisyan on 07.02.17.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RamblerLocationDataDisplayManager.h"
#import "MockObjectsFactory.h"

@interface RamblerLocationDataDisplayManager ()

@property (nonatomic, strong) id<RamblerLocationDataDisplayManagerDelegate> delegate;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface RamblerLocationDataDisplayManagerTests : XCTestCase

@property (nonatomic, strong) RamblerLocationDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) id delegateMock;

@end

@implementation RamblerLocationDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    
    self.dataDisplayManager = [RamblerLocationDataDisplayManager new];
    self.delegateMock = OCMProtocolMock(@protocol(RamblerLocationDataDisplayManagerDelegate));
    self.dataDisplayManager.delegate = self.delegateMock;
}

- (void)tearDown {
    self.delegateMock = nil;
    self.dataDisplayManager = nil;
    
    [super tearDown];
}

- (void)testThatDDMSetDelegateCorrectly {
    // given
    id delegate = [MockObjectsFactory generateRandomNumber];
    
    // when
    [self.dataDisplayManager setDelegate:delegate];
    
    // then
    XCTAssertEqualObjects(delegate, self.dataDisplayManager.delegate);
}

- (void)testThatDDMHandleScrollViewDidScroll {
    // given
    id scrollView = [UIScrollView new];
    
    // when
    [self.dataDisplayManager scrollViewDidScroll:scrollView];
    
    // then
    OCMVerify([self.delegateMock scrollViewDidScroll:scrollView]);
}

@end
