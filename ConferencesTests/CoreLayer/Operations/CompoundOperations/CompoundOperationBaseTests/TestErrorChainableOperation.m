//
//  TestErrorChainableOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TestErrorChainableOperation.h"

@implementation TestErrorChainableOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

- (void)main {
    NSError *error = [NSError errorWithDomain:@"ErrorDomain" code:0 userInfo:nil];
    
    [self.delegate didCompleteChainableOperationWithError:error];
}

@end
