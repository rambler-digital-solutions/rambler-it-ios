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
#import <UIKit/UIKit.h>

#import "QuickActionUserActivityFactory.h"

@interface QuickActionUserActivityFactoryTests : XCTestCase

@property (nonatomic, strong) QuickActionUserActivityFactory *factory;

@end

@implementation QuickActionUserActivityFactoryTests

- (void)setUp {
    [super setUp];
    
    self.factory = [QuickActionUserActivityFactory new];
}

- (void)tearDown {
    self.factory = nil;
    
    [super tearDown];
}

- (void)testThatFactoryCreatesUserActivity {
    // given
    NSString *const kTestType = @"1234";
    NSDictionary *const kTestUserInfo = @{
                                          @"key" : @"value"
                                          };
    UIApplicationShortcutItem *item = [self generateShortcutItemWithType:kTestType
                                                                userInfo:kTestUserInfo];
    
    // when
    NSUserActivity *result = [self.factory createUserActivityFromShortcutItem:item];
    
    // then
    XCTAssertNotNil(result);
    XCTAssertEqualObjects(result.activityType, kTestType);
    XCTAssertEqualObjects(result.userInfo, kTestUserInfo);
}

#pragma mark - Helper methods

- (UIApplicationShortcutItem *)generateShortcutItemWithType:(NSString *)type
                                                   userInfo:(NSDictionary *)userInfo {
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:type
                                                                       localizedTitle:@"test"
                                                                    localizedSubtitle:@"test"
                                                                                 icon:nil
                                                                             userInfo:userInfo];
    return item;
}

@end
