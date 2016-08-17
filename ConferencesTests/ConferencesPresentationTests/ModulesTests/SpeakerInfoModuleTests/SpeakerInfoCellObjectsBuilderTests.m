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

#import "SpeakerInfoCellObjectBuilder.h"
#import "SpeakerInfoSectionHeaderCellObject.h"
#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoSocialContactsCellObject.h"
#import "SpeakerPlainObject.h"
#import "SocialNetworkAccountPlainObject.h"

@interface SpeakerInfoCellObjectsBuilderTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoCellObjectBuilder *builder;

@end

@implementation SpeakerInfoCellObjectsBuilderTests

- (void)setUp {
    [super setUp];
    
    self.builder = [SpeakerInfoCellObjectBuilder new];
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
