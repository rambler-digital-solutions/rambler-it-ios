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
#import "EventPresenterStateStorage.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"
#import "EventCellObjectBuilderFactory.h"

@interface EventModuleAssembly ()

@property (strong, nonatomic, readonly) EventCellObjectBuilderFactory *eventCellObjectBuilderFactory;

@end

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
                                [definition injectProperty:@selector(eventService)
                                                      with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(eventPrototypeMapper)
                                                      with:[self.serviceComponents eventPrototypeMapper]];
                                [definition injectProperty:@selector(eventTypeDeterminator)
                                                      with:[self.presentationLayerHelpersAssembly eventTypeDeterminator]];
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
    return [TyphoonDefinition withClass:[EventDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(cellObjectBuilderFactory)
                                                    with:self.eventCellObjectBuilderFactory];
    }];
}

- (EventPresenterStateStorage *)presenterStateStorage {
    return [TyphoonDefinition withClass:[EventPresenterStateStorage class]];
}

@end