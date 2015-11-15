//
//  ServiceComponentsImplementation.h
//  Conferences
//
//  Created by Karpushin Artem on 07/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceComponents.h"

#import "OperationFactoriesAssembly.h"

@interface ServiceComponentsAssembly : TyphoonAssembly <ServiceComponents>

@property (strong, nonatomic, readonly) OperationFactoriesAssembly *operationFactoriesAssembly;

@end
