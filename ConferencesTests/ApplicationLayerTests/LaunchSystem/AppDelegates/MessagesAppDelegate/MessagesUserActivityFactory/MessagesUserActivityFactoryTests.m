//
//  MessagesUserActivityFactoryTests.m
//  Conferences
//
//  Created by Trishina Ekaterina on 14/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import <CoreSpotlight/CoreSpotlight.h>
#import "MessagesUserActivityFactory.h"

@interface MessagesUserActivityFactoryTests : XCTestCase

@property (nonatomic, strong) MessagesUserActivityFactory *factory;

@end

@implementation MessagesUserActivityFactoryTests

- (void)setUp {
    [super setUp];

    self.factory = [MessagesUserActivityFactory new];
}

- (void)tearDown {
    self.factory = nil;
    
    [super tearDown];
}

- (void)testThatFactoryCreatesUserActivity {
    // given
    NSString *givenType = @"EventModelObject";
    NSString *givenIdentifier = @"EventModelObject_42";
    NSString *stringURL = [NSString stringWithFormat:@"ramblerconferences://report?type=%@&id=%@", givenType, givenIdentifier];

    // when
    NSUserActivity *result = [self.factory createUserActivityFromURL:[NSURL URLWithString:stringURL]];

    //then
    XCTAssertNotNil(result);
    XCTAssertEqualObjects(result.activityType, givenType);
    XCTAssertEqualObjects(result.userInfo[CSSearchableItemActivityIdentifier], givenIdentifier);
}

@end
