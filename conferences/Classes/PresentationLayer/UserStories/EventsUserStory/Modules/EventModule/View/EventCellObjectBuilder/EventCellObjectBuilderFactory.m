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
#import "EventCellObjectBuilderBase.h"
#import "PresentationLayerHelpersAssembly.h"

@interface EventCellObjectBuilderFactory ()

@property (strong, nonatomic, readonly) PresentationLayerHelpersAssembly *presentationLayerHelpersAssembly;

@end

@implementation EventCellObjectBuilderFactory

- (EventCellObjectBuilderBase *)builderForEventType:(NSNumber *)eventType {
    return [TyphoonDefinition withOption:eventType matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(FutureEvent)
                       use:[self futureEventCellObjectBuilder]];
        [matcher caseEqual:@(CurrentEvent)
                       use:[self currentEventCellObjectBuilder]];
        [matcher caseEqual:@(PastEvent)
                       use:[self pastEventCellObjectBuilder]];
    }];
}

- (EventCellObjectBuilderBase *)eventCellObjectBuilderBase {
    return [TyphoonDefinition withClass:[EventCellObjectBuilderBase class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                          with:[self.presentationLayerHelpersAssembly dateFormatter]];
    }];
}

- (EventCellObjectBuilderBase *)currentEventCellObjectBuilder {
    return [TyphoonDefinition withClass:[CurrentEventCellObjectBuilder class]
                          configuration:^(TyphoonDefinition *definition) {
                              definition.parent = [self eventCellObjectBuilderBase];
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

@end
