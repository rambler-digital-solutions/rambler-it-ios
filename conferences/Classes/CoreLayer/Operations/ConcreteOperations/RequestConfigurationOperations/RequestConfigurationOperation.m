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

#import "RequestConfigurationOperation.h"

#import "RequestConfigurator.h"
#import "RequestDataModel.h"

#import <CocoalumberJack/CocoaLumberjack.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface RequestConfigurationOperation ()

@property (nonatomic, strong) id<RequestConfigurator> requestConfigurator;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *serviceName;
@property (nonatomic, strong) NSArray *urlParameters;

@end

@implementation RequestConfigurationOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Initialization

- (instancetype)initWithRequestConfigurator:(id<RequestConfigurator>)configurator
                                     method:(NSString *)method
                                serviceName:(NSString *)serviceName
                              urlParameters:(NSArray *)urlParameters {
    self = [super init];
    if (self) {
        _requestConfigurator = configurator;
        _method = method;
        _serviceName = serviceName;
        _urlParameters = urlParameters;
    }
    return self;
}

+ (instancetype)operationWithRequestConfigurator:(id<RequestConfigurator>)configurator
                                          method:(NSString *)method
                                     serviceName:(NSString *)serviceName
                                   urlParameters:(NSArray *)urlParameters {
    return [[[self class] alloc] initWithRequestConfigurator:configurator
                                                      method:method
                                                 serviceName:serviceName
                                               urlParameters:urlParameters];
}

#pragma mark - Operation execution

- (void)main {
    DDLogVerbose(@"The operation %@ is started", NSStringFromClass([self class]));
    RequestDataModel *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[RequestDataModel class]] || data == nil) {
            DDLogVerbose(@"The input data for the operation %@ has passed the validation", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"The input data for the operation %@ hasn't passed the validation. The input data type is: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    NSURLRequest *request = [self.requestConfigurator requestWithMethod:self.method
                                                            serviceName:self.serviceName
                                                          urlParameters:self.urlParameters
                                                       requestDataModel:inputData];
    
    DDLogVerbose(@"Successfully created a request: %@", request);
    [self completeOperationWithData:request error:nil];
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
                                     [NSString stringWithFormat:@"Works with configurator: %@\n",
                                      [self.requestConfigurator debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
