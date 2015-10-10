//
//  OperationDebugDescriptionFormatter.m
//  Conferences
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "OperationDebugDescriptionFormatter.h"

#import "ChainableOperation.h"

@implementation OperationDebugDescriptionFormatter

+ (NSString *)debugDescriptionForOperation:(NSOperation <ChainableOperation> *)operation
                        withAdditionalInfo:(NSArray *)additionalInfo {
    NSMutableString *debugDescription = [[NSMutableString alloc] init];
    
    // General Information
    [debugDescription appendString:@"====================================\n"];
    [debugDescription appendString:@"The operation class:\n"];
    [debugDescription appendString:[NSString stringWithFormat:@"- %@\n", NSStringFromClass([operation class])]];
    [debugDescription appendString:@"====================================\n"];
    
    // Input Data Description
    id inputData = [operation.input obtainInputDataWithTypeValidationBlock:nil];
    if (inputData) {
        [debugDescription appendString:@"Input data:\n"];
        [debugDescription appendString:[NSString stringWithFormat:@"- Type: %@;\n", NSStringFromClass([inputData class])]];
        [debugDescription appendString:[NSString stringWithFormat:@"- Contents: %@;\n", inputData]];
    } else {
        [debugDescription appendString:@"No input data\n"];
    }
    [debugDescription appendString:@"====================================\n"];
    
    // Dependencies on other operations
    if (operation.dependencies.count > 0) {
        [debugDescription appendString:@"Depends on:\n"];
        [operation.dependencies enumerateObjectsUsingBlock:^(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            NSString *dependencyDescription = [NSString stringWithFormat:@"%li: %@, isExecuting: %i\n", idx, NSStringFromClass([obj class]), obj.isExecuting];
            [debugDescription appendString:dependencyDescription];
        }];
    } else {
        [debugDescription appendString:@"No dependencies on other operations\n"];
    }
    [debugDescription appendString:@"====================================\n"];
    
    // Operation state (flags)
    [debugDescription appendString:@"State:\n"];
    [debugDescription appendString:[NSString stringWithFormat:@"- isExecuting: %i;\n", operation.isExecuting]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isFinished: %i;\n", operation.isFinished]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isCancelled: %i;\n", operation.isCancelled]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isReady: %i;\n", operation.isReady]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isAsynchronous: %i;\n", operation.isAsynchronous]];
    [debugDescription appendString:@"====================================\n"];
    
    // Additional information
    [debugDescription appendString:@"Additional information:\n"];
    for (NSString *infoString in additionalInfo) {
        [debugDescription appendString:infoString];
        [debugDescription appendString:@"\n"];
    }
    
    return [debugDescription copy];
}

@end
