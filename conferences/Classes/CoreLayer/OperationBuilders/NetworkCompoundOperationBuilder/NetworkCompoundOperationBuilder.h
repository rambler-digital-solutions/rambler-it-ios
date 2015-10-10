//
//  NetworkCompoundOperationBuilder.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CompoundOperationBuilderConfig;
@class CompoundOperationBase;
@class OperationChainer;

@protocol RequestConfiguratorsFactory;
@protocol RequestSignersFactory;
@protocol NetworkClientsFactory;
@protocol ResponseDeserializersFactory;
@protocol ResponseValidatorsFactory;
@protocol ResponseMappersFactory;

/**
 @author Egor Tolstoy
 
 This builder is used to create typical network operations, which consist of the following steps:
 - NSURLRequest configuration using the provided parameters
 - NSURLRequest signing with some authentication data
 - Sending NSURLRequest to the remote server and receiving data back
 - Deserializing raw response data
 - Validating the deserialized data
 - Mapping the deserialized data to custom models
 
 Either of this steps can be skipped.
 */
@interface NetworkCompoundOperationBuilder : NSObject

/**
 @author Egor Tolstoy
 
 The main initializer of the NetworkCompoundOperationBuilder
 
 @param chainer The object used to chain operations together
 
 @return NetworkCompoundOperationBuilder
 */
- (instancetype)initWithOperationChainer:(OperationChainer *)chainer;

@property (strong, nonatomic) id<RequestConfiguratorsFactory> requestConfiguratorsFactory;
@property (strong, nonatomic) id<RequestSignersFactory> requestSignersFactory;
@property (strong, nonatomic) id<NetworkClientsFactory> networkClientsFactory;
@property (strong, nonatomic) id<ResponseDeserializersFactory> responseDeserializersFactory;
@property (strong, nonatomic) id<ResponseValidatorsFactory> responseValidatorsFactory;
@property (strong, nonatomic) id<ResponseMappersFactory> responseMappersFactory;

/**
 @author Egor Tolstoy
 
 The method builds a compound operation using the information from the provided config model.
 
 @param config The config model
 
 @return CompoundOperationBase
 */
- (CompoundOperationBase *)buildCompoundOperationWithConfig:(CompoundOperationBuilderConfig *)config;

@end
