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

@implementation MessageExtensionAssembly

- (MessagesViewController *)messageExtension {
    return [TyphoonDefinition withClass:[MessagesViewController class]
                          configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(childViewController)
                              with:[self.eventListAssembly viewEventList]];
    }];
}

@end
