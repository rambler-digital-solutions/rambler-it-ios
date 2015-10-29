//
//  OperationFactoriesAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 15/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "OperationFactoriesAssembly.h"

@class EventOperationFactory;
@class NetworkCompoundOperationBuilder;
@class OperationChainer;

@interface OperationFactoriesAssembly ()

- (EventOperationFactory *)eventOperationFactory;
- (NetworkCompoundOperationBuilder *)networkOperationBuilder;
- (OperationChainer *)operationChainer;

@end
