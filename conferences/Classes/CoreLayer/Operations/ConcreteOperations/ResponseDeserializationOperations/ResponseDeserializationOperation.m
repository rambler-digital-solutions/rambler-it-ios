//
//  ResponseDeserializationOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ResponseDeserializationOperation.h"

#import "ResponseDeserializer.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface ResponseDeserializationOperation ()

@property (strong, nonatomic) id<ResponseDeserializer> responseDeserializer;

@end

@implementation ResponseDeserializationOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Initialization

- (instancetype)initWithResponseDeserializer:(id<ResponseDeserializer>)responseDeserializer {
    self = [super init];
    if (self) {
        _responseDeserializer = responseDeserializer;
    }
    return self;
}

+ (instancetype)operationWithResponseDeserializer:(id<ResponseDeserializer>)responseDeserializer {
    return [[[self class] alloc] initWithResponseDeserializer:responseDeserializer];
}

#pragma mark - Operation execution

- (void)main {
    DDLogVerbose(@"The operation %@ is started", NSStringFromClass([self class]));
    NSData *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSData class]]) {
            DDLogVerbose(@"The input data for the operation %@ has passed the validation", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"The input data for the operation %@ hasn't passed the validation. The input data type is: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Start server response deserialization");
    @weakify(self);
    [self.responseDeserializer deserializeServerResponse:inputData completionBlock:^(NSDictionary *response, NSError *error) {
        @strongify(self);
        if (error) {
            DDLogError(@"ResponseDeserializer in operation %@ has produced error: %@", NSStringFromClass([self class]), error);
        }
        if (response) {
            DDLogVerbose(@"The server response was successfully deserialized: %@", response);
        }
        
        [self completeOperationWithData:response error:error];
    }];
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
                                     [NSString stringWithFormat:@"Works with deserializer: %@\n",
                                      [self.responseDeserializer debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
