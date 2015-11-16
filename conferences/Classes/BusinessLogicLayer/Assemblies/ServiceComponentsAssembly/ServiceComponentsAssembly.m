//
//  ServiceComponentsImplementation.m
//  Conferences
//
//  Created by Karpushin Artem on 07/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ServiceComponentsAssembly.h"
#import "PushNotificationService.h"
#import "EventService.h"
#import "EventServiceImplementation.h"
#import "PushNotificationServiceImplementation.h"
#import "OperationScheduler.h"
#import "OperationSchedulerImplementation.h"
#import "PrototypeMapper.h"
#import "EventPrototypeMapper.h"

@implementation ServiceComponentsAssembly

- (id <PushNotificationService>)pushNotificationService {
    return [TyphoonDefinition withClass:[PushNotificationServiceImplementation class]];
}

- (id <EventService>)eventService {
    return [TyphoonDefinition withClass:[EventServiceImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(eventOperationFactory)
                                                    with:[self.operationFactoriesAssembly eventOperationFactory]];
                              [definition injectProperty:@selector(operationScheduler)
                                                    with:[self operationScheduler]];
        
    }];
}

- (id <OperationScheduler>)operationScheduler {
    return [TyphoonDefinition withClass:[OperationSchedulerImplementation class]];
}

- (id<PrototypeMapper>)eventPrototypeMapper {
    return [TyphoonDefinition withClass:[EventPrototypeMapper class]];
}

@end
