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

#import "SpotlightCoreDataStackCoordinatorImplementation.h"

#import "ContextFiller.h"

#import <CoreData/CoreData.h>

static NSString *const kDataModelName = @"SpotlightIndexer";

@interface SpotlightCoreDataStackCoordinatorImplementation ()

@property (nonatomic, strong) id<ContextFiller> contextFiller;

@end

@implementation SpotlightCoreDataStackCoordinatorImplementation

#pragma mark - Initialization

- (instancetype)initWithContextFiller:(id<ContextFiller>)contextFiller {
    self = [super init];
    if (self) {
        _contextFiller = contextFiller;
    }
    return self;
}

+ (instancetype)coordinatorWithContextFiller:(id<ContextFiller>)contextFiller {
    return [[self alloc] initWithContextFiller:contextFiller];
}

#pragma mark - <SpotlightCoreDataStackCoordinator>

- (void)setupCoreDataStack {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kDataModelName
                                              withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSManagedObjectContext *defaultContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [defaultContext setPersistentStoreCoordinator:coordinator];
    [self.contextFiller setupPrimaryContext:defaultContext];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *databaseFilename = [NSString stringWithFormat:@"%@.sqlite", kDataModelName];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:databaseFilename];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [defaultContext persistentStoreCoordinator];
        [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil
                                                           URL:storeURL
                                                       options:0
                                                         error:nil];
    });
}

@end
