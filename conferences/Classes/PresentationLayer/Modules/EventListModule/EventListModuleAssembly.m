//
//  EventListModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventListModuleAssembly.h"
#import "EventListView.h"
#import "EventListInteractor.h"
#import "EventListPresenter.h"
#import "EventListRouter.h"

@interface  EventListModuleAssembly()
@end


/**
 *  Assembly модуля, который 1
 *
 *  
 */
@implementation  EventListModuleAssembly

- (EventListView *)viewEventList {

    return [TyphoonDefinition withClass:[EventListView class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterEventList]];
             }];
}

- (EventListInteractor *)interactorEventList
{
    return [TyphoonDefinition withClass:[EventListInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterEventList]];
             }];
}

- (EventListPresenter *)presenterEventList
{
    return [TyphoonDefinition withClass:[EventListPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(view) 
                                                  with:[self viewEventList]];                                            
                            [definition injectProperty:@selector(interactor) 
                                                  with:[self interactorEventList]];
                            [definition injectProperty:@selector(router) 
                                                  with:[self routerEventList]];
            }];
}

- (EventListRouter *)routerEventList {
    return [TyphoonDefinition withClass:[EventListRouter class]
                          configuration:^(TyphoonDefinition *definition) {

           }];
}

@end