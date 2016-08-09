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

#import "SpotlightIndexerAssembly.h"

#import "IndexerMonitor.h"
#import "EventObjectIndexer.h"
#import "FetchedResultsControllerChangeProvider.h"
#import "EventObjectTransformer.h"
#import "EventChangeProviderFetchRequestFactory.h"
#import "IndexerStateStorage.h"
#import "IndexerMonitorOperationQueueFactory.h"
#import "SpotlightCoreDataStackCoordinatorImplementation.h"
#import "ContextStorageImplementation.h"
#import "SpeakerObjectIndexer.h"
#import "SpeakerChangeProviderFetchRequestFactory.h"
#import "SpeakerObjectTransformer.h"
#import "LectureObjectIndexer.h"
#import "LectureChangeProviderFetchRequestFactory.h"
#import "LectureObjectTransformer.h"

#import <CoreSpotlight/CoreSpotlight.h>

@implementation SpotlightIndexerAssembly

#pragma mark - IndexMonitor

- (IndexerMonitor *)indexerMonitor {
    return [TyphoonDefinition withClass:[IndexerMonitor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(monitorWithIndexers:changeProviders:stateStorage:queueFactory:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:@[
                                                                                     [self eventObjectIndexer],
                                                                                     [self speakerObjectIndexer],
                                                                                     [self lectureObjectIndexer]
                                                                                     ]];
                                                  [initializer injectParameterWith:@[
                                                                                     [self eventChangeProvider],
                                                                                     [self speakerChangeProvider],
                                                                                     [self lectureChangeProvider]
                                                                                     ]];
                                                  [initializer injectParameterWith:[self indexerStateStorage]];
                                                  [initializer injectParameterWith:[self indexerMonitorOperationQueueFactory]];
                                              }];
                          }];
}

- (IndexerStateStorage *)indexerStateStorage {
    return [TyphoonDefinition withClass:[IndexerStateStorage class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(stateStorageWithContextProvider:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self contextStorage]];
                                              }];
                          }];
}

- (IndexerMonitorOperationQueueFactory *)indexerMonitorOperationQueueFactory {
    return [TyphoonDefinition withClass:[IndexerMonitorOperationQueueFactory class]];
}

#pragma mark - CoreData objects

- (SpotlightCoreDataStackCoordinatorImplementation *)spotlightCoreDataStackCoordinator {
    return [TyphoonDefinition withClass:[SpotlightCoreDataStackCoordinatorImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(coordinatorWithContextFiller:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self contextStorage]];
                                              }];
                          }];
}

- (ContextStorageImplementation *)contextStorage {
    return [TyphoonDefinition withClass:[ContextStorageImplementation class]];
}

#pragma mark - Indexers

- (id<ObjectIndexer>)eventObjectIndexer {
    return [TyphoonDefinition withClass:[EventObjectIndexer class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:searchableIndex:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self eventObjectTransformer]];
                                                  [initializer injectParameterWith:[self searchableIndex]];
                                              }];
                          }];
}

- (id<ObjectIndexer>)speakerObjectIndexer {
    return [TyphoonDefinition withClass:[SpeakerObjectIndexer class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:searchableIndex:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self speakerObjectTransformer]];
                                                  [initializer injectParameterWith:[self searchableIndex]];
                                              }];
                          }];
}

- (id<ObjectIndexer>)lectureObjectIndexer {
    return [TyphoonDefinition withClass:[LectureObjectIndexer class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:searchableIndex:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self lectureObjectTransformer]];
                                                  [initializer injectParameterWith:[self searchableIndex]];
                                              }];
                          }];
}

#pragma mark - ChangeProviders

- (id<ChangeProvider>)eventChangeProvider {
    return [TyphoonDefinition withClass:[FetchedResultsControllerChangeProvider class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(changeProviderWithFetchRequestFactory:objectTransformer:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self eventChangeProviderFetchRequestFactory]];
                                                  [initializer injectParameterWith:[self eventObjectTransformer]];
                                              }];
                              [definition injectProperty:@selector(delegate)
                                                    with:[self indexerMonitor]];
                          }];
}

- (id<ChangeProvider>)speakerChangeProvider {
    return [TyphoonDefinition withClass:[FetchedResultsControllerChangeProvider class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(changeProviderWithFetchRequestFactory:objectTransformer:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self speakerChangeProviderFetchRequestFactory]];
                                                  [initializer injectParameterWith:[self speakerObjectTransformer]];
                                              }];
                              [definition injectProperty:@selector(delegate)
                                                    with:[self indexerMonitor]];
                          }];
}

- (id<ChangeProvider>)lectureChangeProvider {
    return [TyphoonDefinition withClass:[FetchedResultsControllerChangeProvider class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(changeProviderWithFetchRequestFactory:objectTransformer:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self lectureChangeProviderFetchRequestFactory]];
                                                  [initializer injectParameterWith:[self lectureObjectTransformer]];
                                              }];
                              [definition injectProperty:@selector(delegate)
                                                    with:[self indexerMonitor]];
                          }];
}

#pragma mark - ChangeProviderRequestFactories

- (id<ChangeProviderFetchRequestFactory>)eventChangeProviderFetchRequestFactory {
    return [TyphoonDefinition withClass:[EventChangeProviderFetchRequestFactory class]];
}

- (id<ChangeProviderFetchRequestFactory>)speakerChangeProviderFetchRequestFactory {
    return [TyphoonDefinition withClass:[SpeakerChangeProviderFetchRequestFactory class]];
}

- (id<ChangeProviderFetchRequestFactory>)lectureChangeProviderFetchRequestFactory {
    return [TyphoonDefinition withClass:[LectureChangeProviderFetchRequestFactory class]];
}

#pragma mark - ObjectTransformers

- (id<ObjectTransformer>)eventObjectTransformer {
    return [TyphoonDefinition withClass:[EventObjectTransformer class]];
}

- (id<ObjectTransformer>)speakerObjectTransformer {
    return [TyphoonDefinition withClass:[SpeakerObjectTransformer class]];
}

- (id<ObjectTransformer>)lectureObjectTransformer {
    return [TyphoonDefinition withClass:[LectureObjectTransformer class]];
}

#pragma mark - Other

- (CSSearchableIndex *)searchableIndex {
    return [TyphoonDefinition withFactory:[CSSearchableIndex class]
                                 selector:@selector(defaultSearchableIndex)];
}

@end
