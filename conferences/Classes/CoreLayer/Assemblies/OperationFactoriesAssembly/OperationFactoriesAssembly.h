//
//  OperationFactoriesAssembly.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "TyphoonAssembly.h"

@protocol RequestConfiguratorsFactory;
@protocol RequestSignersFactory;
@protocol NetworkClientsFactory;
@protocol ResponseDeserializersFactory;
@protocol ResponseValidatorsFactory;
@protocol ResponseMappersFactory;

@class EventOperationFactory;

@interface OperationFactoriesAssembly : TyphoonAssembly

- (EventOperationFactory *)eventOperationFactory;

@property (strong, nonatomic, readonly) TyphoonAssembly <RequestConfiguratorsFactory> *requestConfiguratorsFactory;
@property (strong, nonatomic, readonly) TyphoonAssembly <RequestSignersFactory> *requestSignersFactory;
@property (strong, nonatomic, readonly) TyphoonAssembly <NetworkClientsFactory> *networkClientsFactory;
@property (strong, nonatomic, readonly) TyphoonAssembly <ResponseDeserializersFactory> *responseDeserializersFactory;
@property (strong, nonatomic, readonly) TyphoonAssembly <ResponseValidatorsFactory> *responseValidatorsFactory;
@property (strong, nonatomic, readonly) TyphoonAssembly <ResponseMappersFactory> *responseMappersFactory;

@end
