//
//  TestChainableOperationWithValidationBlock.m
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TestChainableOperationWithValidationBlock.h"

@implementation TestChainableOperationWithValidationBlock

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

- (void)main {
    NSDictionary *inputData;
    NSException *result;
    @try {
        inputData = [self.input obtainInputDataWithTypeValidationBlock:[self inputDataValidationBlock]];
    }
    @catch (NSException *exception) {
        result = exception;
    }
    @finally {
        id outputData = result ?: [NSObject new];
        [self.output didCompleteChainableOperationWithOutputData:outputData];
        [self.delegate didCompleteChainableOperationWithError:nil];
    }
}

- (ChainableOperationInputTypeValidationBlock)inputDataValidationBlock {
    return ^BOOL(id data){
        if ([data isKindOfClass:[NSDictionary class]]) {
            return YES;
        }
        return NO;
    };
}

@end
