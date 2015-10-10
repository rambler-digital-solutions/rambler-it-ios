//
//  OperationFactoriesAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "OperationFactoriesAssembly.h"

#import "NetworkCompoundOperationBuilder.h"
#import "OperationChainer.h"

#import "EventOperationFactory.h"

@implementation OperationFactoriesAssembly

#pragma mark - Operation factories

- (EventOperationFactory *)eventOperationFactory {
    return [TyphoonDefinition withClass:[EventOperationFactory class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithBuilder:)
                        parameters:^(TyphoonMethod *initializer) {
                            [initializer injectParameterWith:[self networkOperationBuilder]];
                        }];
    }];
}

#pragma mark - Builders

- (NetworkCompoundOperationBuilder *)networkOperationBuilder {
    return [TyphoonDefinition withClass:[NetworkCompoundOperationBuilder class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithOperationChainer:)
                        parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self operationChainer]];
        }];
        
        [definition injectProperty:@selector(requestConfiguratorsFactory)
                              with:self.requestConfiguratorsFactory];
        [definition injectProperty:@selector(requestSignersFactory)
                              with:self.requestSignersFactory];
        [definition injectProperty:@selector(networkClientsFactory)
                              with:self.networkClientsFactory];
        [definition injectProperty:@selector(responseDeserializersFactory)
                              with:self.responseDeserializersFactory];
        [definition injectProperty:@selector(responseValidatorsFactory)
                              with:self.responseValidatorsFactory];
        [definition injectProperty:@selector(responseMappersFactory)
                              with:self.responseMappersFactory];
    }];
}

#pragma mark - Others

- (OperationChainer *)operationChainer {
    return [TyphoonDefinition withClass:[OperationChainer class]];
}

@end
