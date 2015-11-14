//
//  EventModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventModuleAssembly.h"
#import "EventViewController.h"
#import "EventInteractor.h"
#import "EventPresenter.h"
#import "EventRouter.h"
#import "EventDataDisplayManager.h"
#import "PresenterStateStorage.h"

@implementation  EventModuleAssembly

- (EventViewController *)viewEvent {
    return [TyphoonDefinition withClass:[EventViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterEvent]];
                                [definition injectProperty:@selector(dataDisplayManager)
                                                      with:[self dataDisplayManagerEvent]];
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
                                [definition injectProperty:@selector(presenterStateStorage)
                                                      with:[self presenterStateStorage]];
            }];
}

- (EventRouter *)routerEvent {
    return [TyphoonDefinition withClass:[EventRouter class]
                            configuration:^(TyphoonDefinition *definition) {

           }];
}

- (EventDataDisplayManager *)dataDisplayManagerEvent {
    return [TyphoonDefinition withClass:[EventDataDisplayManager class]];
}

- (PresenterStateStorage *)presenterStateStorage {
    return [TyphoonDefinition withClass:[PresenterStateStorage class]];
}

@end