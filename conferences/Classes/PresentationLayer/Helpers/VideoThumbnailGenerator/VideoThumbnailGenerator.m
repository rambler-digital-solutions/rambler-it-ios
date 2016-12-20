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

#import "VideoThumbnailGenerator.h"

#import "YouTubeIdentifierDeriviator.h"

static NSString * const kYouTubeVideoThumbnailFormat = @"https://img.youtube.com/vi/%@/hqdefault.jpg";

@interface VideoThumbnailGenerator ()

@property (nonatomic, strong) YouTubeIdentifierDeriviator *identifierDeriviator;

@end

@implementation VideoThumbnailGenerator

#pragma mark - Initialization

- (instancetype)initWithIdentifierDeriviator:(YouTubeIdentifierDeriviator *)identifierDeriviator; {
    self = [super init];
    if (self) {
        _identifierDeriviator = identifierDeriviator;
    }
    return self;
}

#pragma mark - Public methods

- (NSURL *)generateThumbnailWithVideoURL:(NSURL *)videoURL {
    if (!videoURL) {
        return nil;
    }
    NSArray *thumbnailFormats = [self thumbnailFormats];
    for (NSString *format in thumbnailFormats) {
        
        NSString *videoID = [self.identifierDeriviator deriveIdentifierFromUrl:videoURL];
        
        if (!videoID) {
            continue;
        }
        
        NSString *thumbnailLink = [NSString stringWithFormat:format, videoID];
        return [NSURL URLWithString:thumbnailLink];
    }
    
    return nil;
}

- (NSString *)videoIDFromLink:(NSString *)link
                  regexString:(NSString *)regexString {
    
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    NSArray *array = [regExp matchesInString:link
                                     options:0
                                       range:NSMakeRange(0, link.length)];
    if (array.count == 1) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}

- (NSArray *)thumbnailFormats {
    return @[kYouTubeVideoThumbnailFormat];
}

@end
