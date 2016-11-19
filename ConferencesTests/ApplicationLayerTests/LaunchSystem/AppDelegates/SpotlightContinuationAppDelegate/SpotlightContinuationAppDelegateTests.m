//
//  SpotlightContinuationAppDelegate.m
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <CoreSpotlight/CoreSpotlight.h>
#import "SpotlightContinuationAppDelegate.h"
#import "LaunchRouter.h"

@interface SpotlightContinuationAppDelegateTests : XCTestCase

@property (nonatomic, strong) SpotlightContinuationAppDelegate *appDelegate;
@property (nonatomic, strong) id mockRouter;

@end

@implementation SpotlightContinuationAppDelegateTests

- (void)setUp {
    [super setUp];
    
    self.appDelegate = [SpotlightContinuationAppDelegate new];
    self.mockRouter = OCMProtocolMock(@protocol(LaunchRouter));
    self.appDelegate.router = self.mockRouter;
}

- (void)tearDown {
    self.appDelegate = nil;
    self.mockRouter = nil;
    
    [super tearDown];
}

- (void)testThatAppDelegateContinueUserActivityCorreclty {
    //given
    NSString *searchString = @"searchString";
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:CSQueryContinuationActionType];
    activity.userInfo = @{CSSearchQueryString : searchString};
    
    //when
    BOOL result = [self.appDelegate application:nil
                           continueUserActivity:activity
                             restorationHandler:nil];
    
    //then
    XCTAssertTrue(result);
    OCMVerify([self.mockRouter openScreenWithData:searchString]);
}

- (void)testThatAppDelegateNotContinueUserActivityCorreclty {
    //given
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:CSSearchableItemActionType];
    
    //when
    BOOL result = [self.appDelegate application:nil
                           continueUserActivity:activity
                             restorationHandler:nil];
    
    //then
    XCTAssertFalse(result);
}

@end
