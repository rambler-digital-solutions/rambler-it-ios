//
//  TestCancellableOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TestCancellableOperation.h"

@implementation TestCancellableOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

- (void)main {
    // Эмулируем длительное выполнение операции
    [NSThread sleepForTimeInterval:0.1f];
    NSNumber *operationCompleted = @(YES);
    [self.output didCompleteChainableOperationWithOutputData:operationCompleted];
    [self.delegate didCompleteChainableOperationWithError:nil];
}

@end
