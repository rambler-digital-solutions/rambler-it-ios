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
