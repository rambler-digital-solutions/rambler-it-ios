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

#import "NetworkCompoundOperationBuilder.h"

#import "RequestConfigurationOperation.h"
#import "RequestSigningOperation.h"
#import "NetworkOperation.h"
#import "ResponseDeserializationOperation.h"
#import "ResponseValidationOperation.h"
#import "ResponseMappingOperation.h"
#import "ResponseConverterOperation.h"

#import "RequestConfiguratorsFactory.h"
#import "RequestSignersFactory.h"
#import "NetworkClientsFactory.h"
#import "ResponseDeserializersFactory.h"
#import "ResponseValidatorsFactory.h"
#import "ResponseMappersFactory.h"
#import "ResponseConverterFactory.h"

#import "ChainableOperation.h"
#import "OperationBuffer.h"
#import "OperationChainer.h"
#import "CompoundOperationBase.h"
#import "CompoundOperationBuilderConfig.h"
#import "LastModifiedMapperOperation.h"

@interface NetworkCompoundOperationBuilder ()

@property (strong, nonatomic) NSMutableArray *operationsArray;
@property (strong, nonatomic) OperationChainer *chainer;

@end

@implementation NetworkCompoundOperationBuilder

#pragma mark - Initialization

- (instancetype)initWithOperationChainer:(OperationChainer *)chainer {
    self = [super init];
    if (self) {
        _chainer = chainer;
        _operationsArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Building Compound operation

- (CompoundOperationBase *)buildCompoundOperationWithConfig:(CompoundOperationBuilderConfig *)config
                                              modelObjectId:(NSString *)modelObjectId{
    NSAssert(config, @"Config shouldn't be nil");
    
    [self.operationsArray removeAllObjects];
    
    [self buildRequestConfigurationOperationWithConfig:config];
    [self buildRequestSigningOperationWithConfig:config];
    [self buildNetworkOperationWithConfig:config];
    [self buildLastModifiedMapperOperationWithModelObjectId:modelObjectId];
    [self buildResponseDeserializationOperationWithConfig:config];
    [self buildResponseConverterOperationWithConfig:config];
    [self buildResponseValidationOperationWithConfig:config];
    [self buildResponseMappingOperationWithConfig:config];
    
    CompoundOperationBase *compoundOperation = [self getResultCompoundOperation];
    id inputData = config.inputQueueData;
    if (config.inputDataMappingBlock) {
        inputData = config.inputDataMappingBlock(inputData);
    }
    [compoundOperation.queueInput setOperationQueueInputData:inputData];
    
    return compoundOperation;
}

- (void)buildRequestConfigurationOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    id<RequestConfigurator> configurator = [self.requestConfiguratorsFactory requestConfiguratorWithType:@(config.requestConfigurationType)];
    RequestConfigurationOperation *operation = [RequestConfigurationOperation operationWithRequestConfigurator:configurator method:config.requestMethod serviceName:config.serviceName urlParameters:config.urlParameters];
    [self addOperation:operation];
}

- (void)buildRequestSigningOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    if (config.requestSigningType == RequestSigningDisabledType) {
        return;
    }
    id<RequestSigner> signer = [self.requestSignersFactory requestSignerWithType:@(config.requestSigningType)];
    RequestSigningOperation *operation = [RequestSigningOperation operationWithRequestSigner:signer];
    [self addOperation:operation];
}

- (void)buildNetworkOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    id<NetworkClient> client = [self.networkClientsFactory commonNetworkClient];
    NetworkOperation *operation = [NetworkOperation operationWithNetworkClient:client];
    [self addOperation:operation];
}

- (void)buildResponseDeserializationOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    id<ResponseDeserializer> deserializer = [self.responseDeserializersFactory deserializerWithType:@(config.responseDeserializationType)];
    ResponseDeserializationOperation *operation = [ResponseDeserializationOperation operationWithResponseDeserializer:deserializer];
    [self addOperation:operation];
}

- (void)buildResponseConverterOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    id<ResponseConverter> converter = [self.responseConverterFactory converterResponse];
    ResponseConverterOperation *operation = [ResponseConverterOperation operationWithResponseConverter:converter];
    [self addOperation:operation];
}

- (void)buildResponseValidationOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    id<ResponseValidator> validator = [self.responseValidatorsFactory validatorWithType:@(config.responseValidationType)];
    ResponseValidationOperation *operation = [ResponseValidationOperation operationWithResponseValidator:validator];
    [self addOperation:operation];
}

- (void)buildResponseMappingOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    id <ResponseMapper> mapper = [self.responseMappersFactory mapperWithType:@(config.responseMappingType)];
    ResponseMappingOperation *operation = [ResponseMappingOperation operationWithResponseMapper:mapper mappingContext:config.mappingContext];
    [self addOperation:operation];
}

- (void)buildLastModifiedMapperOperationWithModelObjectId:(NSString *)eventListObjectId {
//    NSDateFormatter *dateFormatter 
    LastModifiedMapperOperation *operation = [LastModifiedMapperOperation operationWithDateFormatter:self.lastModifiedDateFormatter modelObjectId:eventListObjectId];
    [self addOperation:operation];
}

#pragma mark - Processing Operations

- (void)addOperation:(NSOperation<ChainableOperation> *)operation {
    [self.operationsArray addObject:operation];
    NSUInteger operationIndex = [self.operationsArray indexOfObject:operation];
    
    if (operationIndex > 0)  {
        NSUInteger previousOperationIndex = operationIndex - 1;
        NSOperation <ChainableOperation> *parentOperation = self.operationsArray[previousOperationIndex];
        
        OperationBuffer *buffer = [OperationBuffer buffer];
        [self.chainer chainParentOperation:parentOperation
                        withChildOperation:operation
                                withBuffer:buffer];
    }
}

#pragma mark - Getting Result

- (CompoundOperationBase *)getResultCompoundOperation {
    CompoundOperationBase *compoundOperation = [CompoundOperationBase new];
    compoundOperation.maxConcurrentOperationsCount = 1;
    [self.chainer chainCompoundOperation:compoundOperation
            withChainableOperationsQueue:[self.operationsArray copy]];
    
    for (NSOperation <ChainableOperation> *operation in self.operationsArray) {
        [compoundOperation addOperation:operation];
        operation.delegate = compoundOperation;
    }
    
    return compoundOperation;
}

@end
