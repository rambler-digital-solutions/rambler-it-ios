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
#import "PlainEvent.h"
#import "EventType.h"
#import "CurrentEventCellObjectBuilder.h"
#import "FutureEventCellObjectBuilder.h"
#import "PastEventCellObjectBuilder.h"

@implementation EventCellObjectBuilderFactory

- (id<CellObjectBuilderProtocol>)builderForEventType:(NSNumber *)eventType {
    return [TyphoonDefinition withOption:eventType matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(FutureEvent)
                       use:[self futureEventCellObjectBuilder]];
        [matcher caseEqual:@(CurrentEvent)
                       use:[self currentEventCellObjectBuilder]];
        [matcher caseEqual:@(PastEvent)
                       use:[self pastEventCellObjectBuilder]];
    }];
}

- (id <CellObjectBuilderProtocol>)currentEventCellObjectBuilder {
    return [TyphoonDefinition withClass:[CurrentEventCellObjectBuilder class]];
}

- (id <CellObjectBuilderProtocol>)futureEventCellObjectBuilder {
    return [TyphoonDefinition withClass:[FutureEventCellObjectBuilder class]];
}

- (id <CellObjectBuilderProtocol>)pastEventCellObjectBuilder {
    return [TyphoonDefinition withClass:[PastEventCellObjectBuilder class]];
}

@end
