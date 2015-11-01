//
//  EventModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventModuleAssembly.h"
#import "EventTableViewController.h"
#import "EventInteractor.h"
#import "EventPresenter.h"
#import "EventRouter.h"

@implementation  EventModuleAssembly

- (EventTableViewController *)viewEvent {
    return [TyphoonDefinition withClass:[EventTableViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                            [   definition injectProperty:@selector(output)
                                                     with:[self presenterEvent]];
             }];
}

- (EventInteractor *)interactorEvent {
    return [TyphoonDefinition withClass:[EventInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterEvent]];
             }];
}

- (EventPresenter *)presenterEvent {
    return [TyphoonDefinition withClass:[EventPresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewEvent]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorEvent]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerEvent]];
            }];
}

- (EventRouter *)routerEvent {
    return [TyphoonDefinition withClass:[EventRouter class]
                            configuration:^(TyphoonDefinition *definition) {

           }];
}

@end