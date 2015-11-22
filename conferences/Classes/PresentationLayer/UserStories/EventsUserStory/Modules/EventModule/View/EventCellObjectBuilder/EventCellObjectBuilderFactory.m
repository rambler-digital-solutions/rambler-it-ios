//
//  EventCellObjectFactory.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventCellObjectBuilderFactory.h"
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
