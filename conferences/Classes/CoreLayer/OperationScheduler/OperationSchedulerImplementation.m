//
//  OperationSchedulerImplementation.m
//  Conferences
//
//  Created by Egor Tolstoy on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "OperationSchedulerImplementation.h"

static NSString *const kOperationQueueName = @"ru.rambler.Conferences.OperationQueue";

@interface OperationSchedulerImplementation ()

@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation OperationSchedulerImplementation

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.name = kOperationQueueName;
        _queue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    }
    return self;
}

#pragma mark - OperationScheduler

- (void)addOperation:(NSOperation *)operation {
    [self.queue addOperation:operation];
}

@end
