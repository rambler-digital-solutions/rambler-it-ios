//
//  ResponseValidationOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseValidationOperation.h"

#import "ResponseValidator.h"

#import <CocoalumberJack/CocoaLumberjack.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface ResponseValidationOperation ()

@property (strong, nonatomic) id<ResponseValidator> responseValidator;

@end

@implementation ResponseValidationOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Initialization

- (instancetype)initWithResponseValidator:(id<ResponseValidator>)responseValidator {
    self = [super init];
    if (self) {
        _responseValidator = responseValidator;
    }
    return self;
}

+ (instancetype)operationWithResponseValidator:(id<ResponseValidator>)responseValidator {
    return [[[self class] alloc] initWithResponseValidator:responseValidator];
}

#pragma mark - Operation execution

- (void)main {
    DDLogVerbose(@"The operation %@ is started", NSStringFromClass([self class]));
    id inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if (data) {
            DDLogVerbose(@"The input data for the operation %@ has passed the validation", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"The input data for the operation %@ hasn't passed the validation. The input data type is: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Start server response validation");
    NSError *validationError = [self.responseValidator validateServerResponse:inputData];
    if (validationError) {
        DDLogError(@"ResponseValidator in operation %@ has produced an error: %@", NSStringFromClass([self class]), validationError);
    }
    
    [self completeOperationWithData:inputData error:validationError];
}

- (void)completeOperationWithData:(id)data error:(NSError *)error {
    if (data) {
        [self.output didCompleteChainableOperationWithOutputData:data];
        DDLogVerbose(@"The operation %@ output data has been passed to the buffer", NSStringFromClass([self class]));
    }
    
    [self.delegate didCompleteChainableOperationWithError:error];
    DDLogVerbose(@"The operation %@ is over", NSStringFromClass([self class]));
    [self complete];
}

#pragma mark - Debug

- (NSString *)debugDescription {
    NSArray *additionalDebugInfo = @[
                                     [NSString stringWithFormat:@"Works with validator: %@\n",
                                      [self.responseValidator debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
