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

#import "PresentationLayerHelpersAssembly.h"

#import "EventTypeDeterminator.h"
#import "DateFormatter.h"
#import "AppleMapsLinkBuilder.h"
#import "VideoThumbnailGenerator.h"
#import "SafariFactoryImplementation.h"
#import "YouTubeIdentifierDeriviator.h"

@implementation PresentationLayerHelpersAssembly

- (EventTypeDeterminator *)eventTypeDeterminator {
    return [TyphoonDefinition withClass:[EventTypeDeterminator class]];
}

- (DateFormatter *)dateFormatter {
    return [TyphoonDefinition withClass:[DateFormatter class]];
}

- (id<MapLinkBuilder>)appleMapsLinkBuilder {
    return [TyphoonDefinition withClass:[AppleMapsLinkBuilder class]];
}

- (VideoThumbnailGenerator *)videoThumbnailGenerator {
    return [TyphoonDefinition withClass:[VideoThumbnailGenerator class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithIdentifierDeriviator:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self youTubeIdentifierDeriviator]
                                                   ];                                              }];
                          }];
}

- (SafariFactoryImplementation *)safariFactory {
    return [TyphoonDefinition withClass:[SafariFactoryImplementation class]];
}

- (YouTubeIdentifierDeriviator *)youTubeIdentifierDeriviator {
    return [TyphoonDefinition withClass:[YouTubeIdentifierDeriviator class]];
}

@end
