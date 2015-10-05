//
//  NetworkClientsAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "NetworkClientsAssembly.h"

#import "CommonNetworkClient.h"

@implementation NetworkClientsAssembly

#pragma mark - Concrete definitions

- (id<RCFNetworkClient>)commonNetworkClient {
    return [TyphoonDefinition withClass:[CommonNetworkClient class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithURLSession:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[NSURLSession sharedSession]];
        }];
    }];
}

@end
