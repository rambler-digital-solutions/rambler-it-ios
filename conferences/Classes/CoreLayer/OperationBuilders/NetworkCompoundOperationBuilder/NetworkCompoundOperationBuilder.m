//
//  NetworkCompoundOperationBuilder.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "NetworkCompoundOperationBuilder.h"

#import "RequestConfigurationOperation.h"
#import "RequestSigningOperation.h"
#import "NetworkOperation.h"
#import "ResponseDeserializationOperation.h"
#import "ResponseValidationOperation.h"
#import "ResponseMappingOperation.h"

#import "RequestConfiguratorsFactory.h"

#import "ChainableOperation.h"
#import "OperationBuffer.h"
#import "OperationChainer.h"
#import "CompoundOperationBase.h"
#import "CompoundOperationBuilderConfig.h"

@interface NetworkCompoundOperationBuilder ()

@property (strong, nonatomic) NSMutableArray *operationsArray;
@property (strong, nonatomic) OperationChainer *chainer;

@property (strong, nonatomic) id<RequestConfiguratorsFactory> requestConfiguratorsFactory;

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

- (CompoundOperationBase *)buildCompoundOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    return nil;
}

- (void)buildRequestConfigurationOperationWithConfig:(CompoundOperationBuilderConfig *)config {
    id<RCFRequestConfigurator> configurator = [self.requestConfiguratorsFactory requestConfiguratorWithType:@(config.requestConfigurationType)];
    RequestConfigurationOperation *operation = [RequestConfigurationOperation operationWithRequestConfigurator:configurator method:config.requestMethod serviceName:config.serviceName urlParameters:config.urlParameters];
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
