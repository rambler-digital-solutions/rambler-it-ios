//
//  MessageExtensionAssembly.m
//  Conferences
//
//  Created by Trishina Ekaterina on 18/09/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "MessageExtensionAssembly.h"

#import "MessagesViewController.h"

#import "EventListModuleAssembly.h"

#import "PonsomizerAssembly.h"

#import "ServiceComponents.h"

#import "MessagesLaunchHandler.h"

#import "SpotlightIndexerAssembly.h"

@implementation MessageExtensionAssembly

- (MessagesViewController *)messageExtension {
    return [TyphoonDefinition withClass:[MessagesViewController class]
                          configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(eventService)
                              with:[self.serviceComponents eventService]];
        [definition injectProperty:@selector(ponsomizer)
                              with:[self.ponsomizerAssembly ponsomizer]];
        [definition injectProperty:@selector(dataDisplayManager)
                            with:[self.eventListAssembly dataDisplayManagerEventList]];
        [definition injectProperty:@selector(transformer)
                            with:[self.spotlightIndexerAssembly eventObjectTransformer]];
        }];
}

@end





