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

@interface NetworkCompoundOperationBuilder : NSObject

- (instancetype)initWithOperationChainer:(OperationChainer *)chainer;

- (CompoundOperationBase *)buildCompoundOperationWithConfig:(CompoundOperationBuilderConfig *)config;

@end
