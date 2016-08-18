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

#import "ServiceComponentsAssembly.h"

#import "ResourceClientAssembly.h"
#import "ResourceMapperAssembly.h"

#import "PushNotificationService.h"
#import "EventServiceImplementation.h"
#import "PushNotificationServiceImplementation.h"
#import "OperationScheduler.h"
#import "OperationSchedulerImplementation.h"
#import "EventStoreServiceProtocol.h"
#import "EventStoreService.h"
#import "MetaEventServiceImpementation.h"
#import "RamblerLocationServiceImplementation.h"
#import "PonsomizerAssembly.h"
#import "LectureService.h"
#import "LectureServiceImplementation.h"
#import "SpeakerService.h"
#import "SpeakerServiceImplementation.h"
#import "TagServiceImplementation.h"
#import "TagServicePredicateBuilder.h"

@implementation ServiceComponentsAssembly

- (id <PushNotificationService>)pushNotificationService {
    return [TyphoonDefinition withClass:[PushNotificationServiceImplementation class]];
}

- (id <EventService>)eventService {
    return [TyphoonDefinition withClass:[EventServiceImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(eventOperationFactory)
                                                    with:[self.operationFactoriesAssembly eventListOperationFactory]];
                              [definition injectProperty:@selector(operationScheduler)
                                                    with:[self operationScheduler]];
        
    }];
}

- (id <LectureService>)lectureService {
    return [TyphoonDefinition withClass:[LectureServiceImplementation class]];
}

- (id <SpeakerService>)speakerService {
    return [TyphoonDefinition withClass:[SpeakerServiceImplementation class]];
}

- (id <MetaEventService>)metaEventService {
    return [TyphoonDefinition withClass:[MetaEventServiceImpementation class]];
}

- (id <OperationScheduler>)operationScheduler {
    return [TyphoonDefinition withClass:[OperationSchedulerImplementation class]];
}

- (id <EventStoreServiceProtocol>)eventStoreService {
    return [TyphoonDefinition withClass:[EventStoreService class]];
}

- (id<RamblerLocationService>)ramblerLocationService {
    return [TyphoonDefinition withClass:[RamblerLocationServiceImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(client)
                                                    with:[self.resourceClientAssembly commonResourceClient]];
                              [definition injectProperty:@selector(mapper)
                                                    with:[self.resourceMapperAssembly directionObjectMapper]];
                          }];
}

- (id <TagService>)tagService {
    return [TyphoonDefinition withClass:[TagServiceImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(predicateBuilder)
                                                    with:[self tagServicePredicateBuilder]];
                              definition.scope = TyphoonScopeSingleton;
                          }];
}

- (id)tagServicePredicateBuilder {
    return [TyphoonDefinition withClass:[TagServicePredicateBuilder class]];
}

@end
