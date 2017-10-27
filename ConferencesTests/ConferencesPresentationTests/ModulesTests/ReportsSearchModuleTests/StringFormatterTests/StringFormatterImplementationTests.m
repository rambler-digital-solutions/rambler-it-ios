//
//  StringFormatterTests.m
//  ConferencesTests
//
//  Created by a.yakimenko on 24.10.2017.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "StringFormatterImplementation.h"

@interface StringFormatterImplementationTests : XCTestCase

@property (nonatomic, strong) StringFormatterImplementation *stringFormatter;

@end

@implementation StringFormatterImplementationTests

- (void)setUp {
    [super setUp];
    
    self.stringFormatter = [StringFormatterImplementation new];
}

- (void)tearDown {
    self.stringFormatter = nil;
    
    [super tearDown];
}

- (void)testThatStringFormatterWithStringArgumentNilReturnsNil {
    //given
    NSString *string = nil;
    UIColor *color = OCMOCK_ANY;
    NSString *separator = OCMOCK_ANY;
    
    //when
    NSAttributedString *attributedString = [self.stringFormatter colorLinksStringFromString:string
                                                                                      сolor:color
                                                                                  separator:separator];
    
    //then
    XCTAssertNil(attributedString);
}

- (void)testThatStringFormatterWithColorArgumentNilReturnsNil {
    //given
    NSString *string = OCMOCK_ANY;
    UIColor *color = nil;
    NSString *separator = OCMOCK_ANY;

    //when
    NSAttributedString *attributedString = [self.stringFormatter colorLinksStringFromString:string
                                                                                      сolor:color
                                                                                  separator:separator];
    
    //then
    XCTAssertNil(attributedString);
}

- (void)testThatStringFormatterWithSeparatorArgumentNilReturnsStringWithOneLink {
    NSString *string = @"string1, string2";
    UIColor *color = OCMOCK_ANY;
    NSString *separator = nil;
    NSRange firstSubstringRange = NSMakeRange(0, 7);
    NSRange secondSubstringRange = NSMakeRange(7, 4);
    
    //when
    NSAttributedString *attributedString = [self.stringFormatter colorLinksStringFromString:string
                                                                                      сolor:color
                                                                                  separator:separator];
    
    //then
    NSDictionary *firstSubstringAttributes = [attributedString attributesAtIndex:firstSubstringRange.location
                                                           longestEffectiveRange:nil
                                                                         inRange:firstSubstringRange];
    NSString *firstSubstringLink = firstSubstringAttributes[NSLinkAttributeName];
    
    NSDictionary *secondSubstringAttributes = [attributedString attributesAtIndex:secondSubstringRange.location
                                                            longestEffectiveRange:nil
                                                                          inRange:secondSubstringRange];
    NSString *secondSubstringLink = secondSubstringAttributes[NSLinkAttributeName];
    
    XCTAssertEqualObjects(firstSubstringLink, secondSubstringLink);
}

- (void)testThatStringFormatterWithSeparatorArgumentNotFoundReturnsStringWithOneLink {
    NSString *string = @"string1, string2";
    UIColor *color = OCMOCK_ANY;
    NSString *separator = @"!!!!";
    NSRange firstSubstringRange = NSMakeRange(0, 7);
    NSRange secondSubstringRange = NSMakeRange(9, 7);
    
    //when
    NSAttributedString *attributedString = [self.stringFormatter colorLinksStringFromString:string
                                                                                      сolor:color
                                                                                  separator:separator];
    
    //then
    NSDictionary *firstSubstringAttributes = [attributedString attributesAtIndex:firstSubstringRange.location
                                                           longestEffectiveRange:nil
                                                                         inRange:firstSubstringRange];
    NSString *firstSubstringLink = firstSubstringAttributes[NSLinkAttributeName];
    
    NSDictionary *secondSubstringAttributes = [attributedString attributesAtIndex:secondSubstringRange.location
                                                            longestEffectiveRange:nil
                                                                          inRange:secondSubstringRange];
    NSString *secondSubstringLink = secondSubstringAttributes[NSLinkAttributeName];
    
    XCTAssertEqualObjects(firstSubstringLink, secondSubstringLink);
}

- (void)testThatStringFormatterWithEmptyStringArgumentReturnsEmptyAttributedString {
    //given
    NSString *string = @"";
    UIColor *color = OCMOCK_ANY;
    NSInteger expectedStringLength = 0;
    NSString *separator = OCMOCK_ANY;
    
    //when
    NSAttributedString *attributedString = [self.stringFormatter colorLinksStringFromString:string
                                                                                      сolor:color
                                                                                  separator:separator];
    
    //then
    XCTAssertEqual(attributedString.length, expectedStringLength);
}

- (void)testThatStringFormatterReturnsAttributedStringWithCorrectColors {
    //given
    NSString *string = @"string1, string2";
    UIColor *color = [UIColor redColor];
    NSString *separator = @", ";
    NSRange firstSubstringRange = NSMakeRange(0, 7);
    NSRange secondSubstringRange = NSMakeRange(7, 2);
    NSRange thirdSubstringRange = NSMakeRange(9, 7);
    UIColor *expectedColor = [UIColor redColor];
    
    //when
    NSAttributedString *attributedString = [self.stringFormatter colorLinksStringFromString:string
                                                                                      сolor:color
                                                                                  separator:separator];
    
    //then
    NSDictionary *firstSubstringAttributes = [attributedString attributesAtIndex:firstSubstringRange.location
                                                           longestEffectiveRange:nil
                                                                         inRange:firstSubstringRange];
    UIColor *firstSubstringColor = firstSubstringAttributes[NSForegroundColorAttributeName];
    
    NSDictionary *secondSubstringAttributes = [attributedString attributesAtIndex:secondSubstringRange.location
                                                            longestEffectiveRange:nil
                                                                          inRange:secondSubstringRange];
    UIColor *secondSubstringColor = secondSubstringAttributes[NSForegroundColorAttributeName];
    
    NSDictionary *thirdSubstringAttributes = [attributedString attributesAtIndex:thirdSubstringRange.location
                                                           longestEffectiveRange:nil
                                                                         inRange:thirdSubstringRange];
    UIColor *thirdSubstringColor = thirdSubstringAttributes[NSForegroundColorAttributeName];
    
    XCTAssertEqualObjects(firstSubstringColor, expectedColor);
    XCTAssertNil(secondSubstringColor);
    XCTAssertEqualObjects(thirdSubstringColor, expectedColor);
}

- (void)testThatStringFormatterReturnsAttributedStringWithCorrectLinks {
    //given
    NSString *string = @"string1, string2";
    UIColor *color = OCMOCK_ANY;
    NSString *separator = @", ";
    NSRange firstSubstringRange = NSMakeRange(0, 7);
    NSRange secondSubstringRange = NSMakeRange(7, 2);
    NSRange thirdSubstringRange = NSMakeRange(9, 7);
    NSString *expectedFirstSubstringLink = @"string1";
    NSString *expectedThirdSubstringLink = @"string2";
    
    //when
    NSAttributedString *attributedString = [self.stringFormatter colorLinksStringFromString:string
                                                                                      сolor:color
                                                                                  separator:separator];
    
    //then
    NSDictionary *firstSubstringAttributes = [attributedString attributesAtIndex:firstSubstringRange.location
                                                           longestEffectiveRange:nil
                                                                         inRange:firstSubstringRange];
    NSString *firstSubstringLink = firstSubstringAttributes[NSLinkAttributeName];
    
    NSDictionary *secondSubstringAttributes = [attributedString attributesAtIndex:secondSubstringRange.location
                                                            longestEffectiveRange:nil
                                                                          inRange:secondSubstringRange];
    NSString *secondSubstringLink = secondSubstringAttributes[NSLinkAttributeName];
    
    NSDictionary *thirdSubstringAttributes = [attributedString attributesAtIndex:thirdSubstringRange.location
                                                           longestEffectiveRange:nil
                                                                         inRange:thirdSubstringRange];
    NSString *thirdSubstringLink = thirdSubstringAttributes[NSLinkAttributeName];
    
    XCTAssertEqualObjects(firstSubstringLink, expectedFirstSubstringLink);
    XCTAssertNil(secondSubstringLink);
    XCTAssertEqualObjects(thirdSubstringLink, expectedThirdSubstringLink);
}

@end
