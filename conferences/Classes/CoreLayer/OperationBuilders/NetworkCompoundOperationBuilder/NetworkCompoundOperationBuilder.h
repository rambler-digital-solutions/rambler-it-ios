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

@interface NetworkCompoundOperationBuilder : NSObject

- (CompoundOperationBase *)buildCompoundOperationWithConfig:(CompoundOperationBuilderConfig *)config;

@end
