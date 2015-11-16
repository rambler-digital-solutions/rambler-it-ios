//
//  ServiceComponentsAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ServiceComponentsAssembly.h"

@protocol OperationScheduler;

@interface ServiceComponentsAssembly ()

- (id <OperationScheduler>)operationScheduler;

@end
