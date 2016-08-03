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

@property (nonatomic, strong) id<RequestConfiguratorsFactory> requestConfiguratorsFactory;
@property (nonatomic, strong) id<RequestSignersFactory> requestSignersFactory;
@property (nonatomic, strong) id<NetworkClientsFactory> networkClientsFactory;
@property (nonatomic, strong) id<ResponseDeserializersFactory> responseDeserializersFactory;
@property (nonatomic, strong) id<ResponseValidatorsFactory> responseValidatorsFactory;
@property (nonatomic, strong) id<ResponseMappersFactory> responseMappersFactory;
@property (nonatomic, strong, readonly) OperationChainer *chainer;
@property (nonatomic, strong) NSDateFormatter *lastModifiedDateFormatter;

/**
 @author Egor Tolstoy
 
 The method builds a compound operation using the information from the provided config model.
 
 @param config The config model
 
 @return CompoundOperationBase
 */
- (CompoundOperationBase *)buildCompoundOperationWithConfig:(CompoundOperationBuilderConfig *)config
                                              modelObjectId:(NSString *)modelObjectId;

@end
