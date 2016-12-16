// Copyright (c) 2016 RAMBLER&Co
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

#import "YouTubeIdentifierDeriviator.h"

@interface YouTubeIdentifierDeriviatorTests : XCTestCase

@property (nonatomic, strong) YouTubeIdentifierDeriviator *deriviator;

@end

@implementation YouTubeIdentifierDeriviatorTests

- (void)setUp {
    [super setUp];
    
    self.deriviator = [YouTubeIdentifierDeriviator new];
}

- (void)tearDown {
    self.deriviator = nil;
    
    [super tearDown];
}

- (void)testThatChecksYouTubeVideoCorrectly {
    // given
    NSArray *exptectedResult = @[
                                @YES,
                                @YES,
                                @YES,
                                @NO
                                ];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *allFormats = @[
                            @"http://www.youtube.com/v/%@?fs=1&hl=en_US&rel=0",
                            @"http://youtu.be/%@",
                            @"http://www.youtube-nocookie.com/v/%@?version=3&hl=en_US&rel=0",
                            @"http://www.rambler.ru"
                            ];
    
    // when
    for (NSString *linkFormat in allFormats) {
        NSString *stringURL = [linkFormat stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:stringURL];
        BOOL isFromYoutube = [self.deriviator checkIfVideoIsFromYouTube:url];
        [result addObject:@(isFromYoutube)];
    }
    
    // then
    for (NSUInteger i = 0; i < result.count; ++i) {
        XCTAssertEqualObjects(exptectedResult[i], result[i]);
    }
}

- (void)testThatWorksWithAllYouTubeFormats {
    // given
    NSString *videoId = @"dQw4w9WgXcQ";
    NSMutableArray *identifiers = [NSMutableArray new];
    NSArray *allFormats = @[@"http://www.youtube.com/v/%@?fs=1&hl=en_US&rel=0",
                            @"http://www.youtube.com/embed/%@?rel=0",
                            @"http://www.youtube.com/watch?v=%@&feature=feedrec_grec_index",
                            @"http://www.youtube.com/watch?v=%@",
                            @"http://youtu.be/%@",
                            @"http://www.youtube.com/watch?v=%@#t=0m10s",
                            @"http://youtu.be/%@",
                            @"http://www.youtube.com/embed/%@",
                            @"http://www.youtube.com/v/%@",
                            @"http://www.youtube.com/e/%@",
                            @"http://www.youtube.com/watch?v=%@",
                            @"http://www.youtube.com/?v=%@",
                            @"http://www.youtube.com/watch?feature=player_embedded&v=%@",
                            @"http://www.youtube.com/?feature=player_embedded&v=%@",
                            @"http://www.youtube-nocookie.com/v/%@?version=3&hl=en_US&rel=0"];
    
    // when
    for (NSString *linkFormat in allFormats) {
        NSString *URLString = [NSString stringWithFormat:linkFormat, videoId];
        NSURL *url = [NSURL URLWithString:URLString];
        NSString *identifier = [self.deriviator deriveIdentifierFromUrl:url];
        if (!identifier) {
            return;
        }
        [identifiers addObject:identifier];
    }
    
    // then
    for (NSString *identifier in identifiers) {
        XCTAssertEqualObjects(identifier, videoId);
    }
}

@end
