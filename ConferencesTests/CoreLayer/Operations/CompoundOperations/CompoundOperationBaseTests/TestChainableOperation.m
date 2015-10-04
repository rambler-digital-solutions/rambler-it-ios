//
//  TestChainableOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TestChainableOperation.h"

@implementation TestChainableOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

- (void)main {
    NSString *inputString = [self.input obtainInputDataWithTypeValidationBlock:nil];
    NSString *processedString = [NSString stringWithFormat:@"%@-processed", inputString];
    [self.output didCompleteChainableOperationWithOutputData:processedString];
    
    [self.delegate didCompleteChainableOperationWithError:nil];
}

@end
