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
#import "SpotlightCoreDataStackCoordinator.h"

#import <CoreSpotlight/CoreSpotlight.h>

@implementation SpotlightIndexerAssembly

#pragma mark - IndexMonitor

- (SpotlightCoreDataStackCoordinator *)spotlightCoreDataStackCoordinator {
    return [TyphoonDefinition withClass:[SpotlightCoreDataStackCoordinator class]];
}

- (IndexerMonitor *)indexerMonitor {
    return [TyphoonDefinition withClass:[IndexerMonitor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(monitorWithIndexers:changeProviders:stateStorage:queueFactory:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:@[
                                                                                     [self eventObjectIndexer]
                                                                                     ]];
                                                  [initializer injectParameterWith:@[[self eventChangeProvider]]];
                                                  [initializer injectParameterWith:[self indexerStateStorage]];
                                                  [initializer injectParameterWith:[self indexerMonitorOperationQueueFactory]];
                                              }];
                          }];
}

- (IndexerStateStorage *)indexerStateStorage {
    return [TyphoonDefinition withClass:[IndexerStateStorage class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(coordinator)
                              with:[self spotlightCoreDataStackCoordinator]];
    }];
}

- (IndexerMonitorOperationQueueFactory *)indexerMonitorOperationQueueFactory {
    return [TyphoonDefinition withClass:[IndexerMonitorOperationQueueFactory class]];
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
                              [definition injectProperty:@selector(coordinator)
                                                    with:[self spotlightCoreDataStackCoordinator]];
                          }];
}

#pragma mark - ChangeProviderRequestFactories

- (id<ChangeProviderFetchRequestFactory>)eventChangeProviderFetchRequestFactory {
    return [TyphoonDefinition withClass:[EventChangeProviderFetchRequestFactory class]];
}

#pragma mark - ObjectTransformers

- (id<ObjectTransformer>)eventObjectTransformer {
    return [TyphoonDefinition withClass:[EventObjectTransformer class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(coordinator)
                              with:[self spotlightCoreDataStackCoordinator]];
    }];
}

#pragma mark - Other

- (CSSearchableIndex *)searchableIndex {
    return [TyphoonDefinition withFactory:[CSSearchableIndex class]
                                 selector:@selector(defaultSearchableIndex)];
}

@end
