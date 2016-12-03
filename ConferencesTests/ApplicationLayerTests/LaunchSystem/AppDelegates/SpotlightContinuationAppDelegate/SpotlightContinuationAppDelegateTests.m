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
    BOOL result = [self.appDelegate application:[UIApplication sharedApplication]
                           continueUserActivity:activity
                             restorationHandler:^(NSArray * _Nullable restorableObjects) {}];
    
    //then
    XCTAssertTrue(result);
    OCMVerify([self.mockRouter openScreenWithData:searchString]);
}

- (void)testThatAppDelegateNotContinueUserActivityCorrectly {
    //given
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:CSSearchableItemActionType];
    
    //when
    BOOL result = [self.appDelegate application:[UIApplication sharedApplication]
                           continueUserActivity:activity
                             restorationHandler:^(NSArray * _Nullable restorableObjects) {}];
    
    //then
    XCTAssertFalse(result);
}

@end
