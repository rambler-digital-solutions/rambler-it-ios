//
//  SpeakerInfoCellObjectsBuilderTests.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 05/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "SpeakerInfoCellObjectsBuilder.h"
#import "SpeakerInfoSectionHeaderCellObject.h"
#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoSocialContactsCellObject.h"
#import "SpeakerPlainObject.h"
#import "SocialNetworkAccountPlainObject.h"

@interface SpeakerInfoCellObjectsBuilderTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoCellObjectsBuilder *builder;

@end

@implementation SpeakerInfoCellObjectsBuilderTests

- (void)setUp {
    [super setUp];
    
    self.builder = [SpeakerInfoCellObjectsBuilder new];
}

- (void)tearDown {
    
    self.builder = nil;
    
    [super tearDown];
}

- (void)testThatBuildCellObjects {
    //given
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    id website = [self configureSocialAccountWithType:SocialNetworkWebsiteType];
    id twitter = [self configureSocialAccountWithType:SocialNetworkTwitterType];
    speaker.socialNetworkAccounts = [NSSet setWithArray:@[website, twitter]];
    NSArray *cellObjectClasses = @[[SpeakerInfoTableViewCellObject class], [SpeakerInfoSectionHeaderCellObject class], [SpeakerInfoSocialContactsCellObject class], [SpeakerInfoSectionHeaderCellObject class], [SpeakerInfoSocialContactsCellObject class]];
    //when
    NSArray *result = [self.builder buildObjectsWithSpeaker:speaker];
    
    //then
    XCTAssertEqual(result.count, cellObjectClasses.count);
    for (NSInteger index = 0; index < result.count; index++) {
        NSObject *cellObject = result[index];
        Class expectedClass = cellObjectClasses[index];
        XCTAssertEqual(cellObject.class, expectedClass);
    }
}

- (SocialNetworkAccountPlainObject *)configureSocialAccountWithType:(SocialNetworkType)type {
    SocialNetworkAccountPlainObject *account = [SocialNetworkAccountPlainObject new];
    account.type = @(type);
    return account;
}

@end
