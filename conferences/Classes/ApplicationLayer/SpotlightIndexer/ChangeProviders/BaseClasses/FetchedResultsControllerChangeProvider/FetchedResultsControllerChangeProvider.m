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

#import "FetchedResultsControllerChangeProvider.h"

#import "ChangeProviderDelegate.h"
#import "ObjectTransformer.h"
#import "ChangeProviderChangeType.h"

#import <MagicalRecord/MagicalRecord.h>

@interface FetchedResultsControllerChangeProvider () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchRequest *request;
@property (nonatomic, strong) id<ObjectTransformer> transformer;
@property (nonatomic, strong) NSFetchedResultsController *controller;

@end

@implementation FetchedResultsControllerChangeProvider

#pragma mark - Initialization

- (instancetype)initWithFetchedRequest:(NSFetchRequest *)request
                     objectTransformer:(id<ObjectTransformer>)objectTransformer {
    self = [super init];
    if (self) {
        _request = request;
        _transformer = objectTransformer;
    }
    return self;
}

+ (instancetype)changeProviderWithFetchedRequest:(NSFetchRequest *)request
                               objectTransformer:(id<ObjectTransformer>)objectTransformer {
    return [[self alloc] initWithFetchedRequest:request
                              objectTransformer:objectTransformer];
}

#pragma mark - Public methods

- (void)startMonitoringForChanges {
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    
    self.controller = [[NSFetchedResultsController alloc] initWithFetchRequest:self.request
                                                          managedObjectContext:defaultContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
    self.controller.delegate = self;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    NSString *objectType = NSStringFromClass([anObject class]);
    NSString *objectIdentifier = [self.transformer identifierForObject:anObject];
    ChangeProviderChangeType changeType = [self changeTypeFromCoreDataChangeType:type];
    
    [self.delegate changeProvider:self
             didGetChangeWithType:changeType
                    forObjectType:objectType
                 objectIdentifier:objectIdentifier];
}

#pragma mark - Private methods

- (ChangeProviderChangeType)changeTypeFromCoreDataChangeType:(NSFetchedResultsChangeType)type {
    static NSDictionary *mappingDictionary;
    if (!mappingDictionary) {
        mappingDictionary = @{
                              @(NSFetchedResultsChangeInsert) : @(ChangeProviderChangeInsert),
                              @(NSFetchedResultsChangeDelete) : @(ChangeProviderChangeDelete),
                              @(NSFetchedResultsChangeMove) : @(ChangeProviderChangeMove),
                              @(NSFetchedResultsChangeUpdate) : @(ChangeProviderChangeUpdate)
                              };
    }
    return [mappingDictionary[@(type)] integerValue];
}

@end
