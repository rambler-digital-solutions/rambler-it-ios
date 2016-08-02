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

#import "IndexerMonitor.h"

#import "ChangeProvider.h"
#import "ChangeProviderDelegate.h"

@interface IndexerMonitor () <ChangeProviderDelegate>

@property (nonatomic, strong) NSDictionary *indexers;
@property (nonatomic, strong) NSDictionary *changeProviders;

@end

@implementation IndexerMonitor

#pragma mark - Public methods

- (void)startMonitoring {
    
}

- (void)stopMonitoring {
    
}

- (void)addIndexer:(id<ObjectIndexer>)indexer withChangeProvider:(id<ChangeProvider>)changeProvider {
    NSString *identifier = [self generateUniqueIdentifierForIndexerAndChangeProviderPair];
    
    NSMutableDictionary *mutableIndexers = [self.indexers mutableCopy];
    mutableIndexers[identifier] = indexer;
    self.indexers = [mutableIndexers copy];
    
    NSMutableDictionary *mutableChangeProviders = [self.changeProviders mutableCopy];
    mutableChangeProviders[identifier] = changeProvider;
    self.changeProviders = [mutableChangeProviders copy];
}

#pragma mark - <ChangeProviderDelegate>

- (void)changeProvider:(id<ChangeProvider>)changeProvider
       didChangeObject:(id)object
            changeType:(ChangeProviderChangeType)changeType {
    NSString *indexerIdentifier = [[self.changeProviders allKeysForObject:changeProvider] firstObject];
    id<ObjectIndexer> indexer = self.indexers[indexerIdentifier];
}

- (void)processChanges {
    
}

- (NSArray *)obtainObjectsForInitialIndexing {
    
}

#pragma mark - Private methods

- (NSString *)generateUniqueIdentifierForIndexerAndChangeProviderPair {
    return [[NSUUID UUID] UUIDString];
}

@end
