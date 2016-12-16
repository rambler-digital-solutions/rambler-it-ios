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

#import "EventCellObjectBuilderFactory.h"
#import "EventType.h"
#import "CurrentEventCellObjectBuilder.h"
#import "FutureEventCellObjectBuilder.h"
#import "PastEventCellObjectBuilder.h"
#import "EventCellObjectBuilderBase.h"
#import "PresentationLayerHelpersAssembly.h"
#import "LectureInfoTableViewCellCalculator.h"
#import "LectureInfoTableViewCellObjectMapper.h"

@interface EventCellObjectBuilderFactory ()

@property (nonatomic, strong, readonly) PresentationLayerHelpersAssembly *presentationLayerHelpersAssembly;

@end

@implementation EventCellObjectBuilderFactory

- (EventCellObjectBuilderBase *)builderForEventType:(NSNumber *)eventType {
    return [TyphoonDefinition withOption:eventType matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(FutureEvent)
                       use:[self futureEventCellObjectBuilder]];
        [matcher caseEqual:@(CurrentEvent)
                       use:[self pastEventCellObjectBuilder]];
        [matcher caseEqual:@(PastEvent)
                       use:[self pastEventCellObjectBuilder]];
    }];
}

- (EventCellObjectBuilderBase *)eventCellObjectBuilderBase {
    return [TyphoonDefinition withClass:[EventCellObjectBuilderBase class]
                          configuration:^(TyphoonDefinition *definition) {
                              definition.abstract = YES;
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
                              [definition injectProperty:@selector(lectureInfoCellObjectMapper)
                                                    with:[self lectureInfoInEventCellObjectMapper]];
    }];
}

- (EventCellObjectBuilderBase *)futureEventCellObjectBuilder {
    return [TyphoonDefinition withClass:[FutureEventCellObjectBuilder class]
                          configuration:^(TyphoonDefinition *definition) {
                              definition.parent = [self eventCellObjectBuilderBase];
    }];
}

- (EventCellObjectBuilderBase *)pastEventCellObjectBuilder {
    return [TyphoonDefinition withClass:[PastEventCellObjectBuilder class]
                          configuration:^(TyphoonDefinition *definition) {
                              definition.parent = [self eventCellObjectBuilderBase];
    }];
}

#pragma mark - Private methods

- (LectureInfoTableViewCellObjectMapper *)lectureInfoInEventCellObjectMapper {
    return [TyphoonDefinition withClass:[LectureInfoTableViewCellObjectMapper class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(calculator)
                                                    with:[self lectureInfoInEventCellCalculator]];
                          }];
}

- (LectureInfoTableViewCellCalculator *)lectureInfoInEventCellCalculator {
    return [TyphoonDefinition withClass:[LectureInfoTableViewCellCalculator class]];
}

@end
