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
#import <OCMock/OCMock.h>

#import "VideoThumbnailGenerator.h"
#import "YouTubeIdentifierDeriviator.h"

@interface VideoThumbnailTests : XCTestCase

@property (nonatomic, strong) VideoThumbnailGenerator *generator;

@property (nonatomic, strong) id mockDeriviator;

@end

@implementation VideoThumbnailTests

- (void)setUp {
    [super setUp];
    
    self.mockDeriviator = OCMClassMock([YouTubeIdentifierDeriviator class]);
    self.generator = [[VideoThumbnailGenerator alloc] initWithIdentifierDeriviator:self.mockDeriviator];
}

- (void)tearDown {
    self.generator = nil;
    
    [self.mockDeriviator stopMocking];
    self.mockDeriviator = nil;
    
    [super tearDown];
}

- (void)testGenerateThumbnail {
    // given
    NSString *videoID = @"i-7engtLj4U";
    OCMStub([self.mockDeriviator deriveIdentifierFromUrl:OCMOCK_ANY]).andReturn(videoID);
    NSString *originalURLString = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", videoID];
    NSString * expectedTumbnailURLString = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/hqdefault.jpg", videoID];
    NSURL *originalURL = [NSURL URLWithString:originalURLString];
    
    // when
    NSURL *tumbnailURL = [self.generator generateThumbnailWithVideoURL:originalURL];
    
    // then
    XCTAssertEqualObjects([tumbnailURL absoluteString], expectedTumbnailURLString);
}

- (void)testAllYoutubeLinkFormats {
    // given
    NSString *videoID = @"dQw4w9WgXcQ";
    OCMStub([self.mockDeriviator deriveIdentifierFromUrl:OCMOCK_ANY]).andReturn(videoID);
    NSMutableArray *tumbnails = [NSMutableArray new];
    NSString * expectedTumbnailURLString = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/hqdefault.jpg", videoID];
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
        NSString *URLString = [NSString stringWithFormat:linkFormat, videoID];
        NSURL *url = [NSURL URLWithString:URLString];
        NSURL *tumbnailURL = [self.generator generateThumbnailWithVideoURL:url];
        if (!tumbnailURL) {
            return;
        }
        [tumbnails addObject:tumbnailURL];
    }
    
    // then
    for (NSURL *tumbnailURL in tumbnails) {
        XCTAssertEqualObjects([tumbnailURL absoluteString], expectedTumbnailURLString);
    }
    
}

@end
