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

#import "NetworkOperation.h"

#import "NetworkClient.h"
#import "ServerResponseModel.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

static const int ddLogLevel = DDLogFlagVerbose;

@interface NetworkOperation ()

@property (strong, nonatomic) id<NetworkClient> networkClient;

@end

@implementation NetworkOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Initialization

- (instancetype)initWithNetworkClient:(id<NetworkClient>)networkClient {
    self = [super init];
    if (self) {
        _networkClient = networkClient;
    }
    return self;
}

+ (instancetype)operationWithNetworkClient:(id<NetworkClient>)networkClient {
    return [[[self class] alloc] initWithNetworkClient:networkClient];
}

#pragma mark - Operation execution

- (void)main {
    DDLogVerbose(@"The operation %@ is started", NSStringFromClass([self class]));
    NSURLRequest *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSURLRequest class]]) {
            DDLogVerbose(@"The input data for the operation %@ has passed the validation", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"The input data for the operation %@ hasn't passed the validation. The input data type is: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Start sending request to the remote server");
    @weakify(self);
    [self.networkClient sendRequest:inputData completionBlock:^(ServerResponseModel *responseModel, NSError *error) {
        @strongify(self);
        if (error) {
            DDLogError(@"NetworkClient in operation %@ has produced an error: %@", NSStringFromClass([self class]), error);
        }
        if (responseModel) {
            DDLogVerbose(@"Server returned data with length: %li", [(NSData *)responseModel.data length]);
        }
        
        [self completeOperationWithData:responseModel.data error:error];
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
                                     [NSString stringWithFormat:@"Works with client: %@\n",
                                      [self.networkClient debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
