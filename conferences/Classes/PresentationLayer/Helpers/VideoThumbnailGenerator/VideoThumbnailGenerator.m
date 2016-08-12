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

static NSString * const kYouTubeVideoRegExp = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|((?<=e/)))([\\w-]++)";
static NSString * const kYouTubeVideoThumbnailFormat = @"http://img.youtube.com/vi/%@/hqdefault.jpg";

@implementation VideoThumbnailGenerator

- (NSURL *)generateThumbnailWithVideoURL:(NSURL *)videoURL {
    NSString *videoString = [videoURL absoluteString];
    NSDictionary *regExpToThumbnailFormats = [self regExpToThumbnailFormats];
    for (NSString *regexString in [regExpToThumbnailFormats allKeys]) {
        
        NSString *videoID = [self videoIDFromLink:videoString
                                      regexString:regexString];
        
        if (!videoID) {
            continue;
        }
        
        NSString *thumbnailFormat = [regExpToThumbnailFormats valueForKey:regexString];
        NSString *thumbnailLink = [NSString stringWithFormat:thumbnailFormat, videoID];
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

- (NSDictionary *)regExpToThumbnailFormats {
    return @{kYouTubeVideoRegExp : kYouTubeVideoThumbnailFormat};
}

@end
