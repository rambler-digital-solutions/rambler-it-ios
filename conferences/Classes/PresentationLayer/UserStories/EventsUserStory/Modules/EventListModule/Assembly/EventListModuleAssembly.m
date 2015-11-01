//
//  EventListModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventListModuleAssembly.h"
#import "EventListTableViewController.h"
#import "EventListInteractor.h"
#import "EventListPresenter.h"
#import "EventListRouter.h"
#import "EventListDataDisplayManager.h"
#import "ServiceComponents.h"

#import "TabBarButtonPrototype.h"

static NSString * const kEventListStoryboardName = @"EventsUserStory";

@implementation  EventListModuleAssembly

- (EventListTableViewController *)viewEventList {
    return [TyphoonDefinition withClass:[EventListTableViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterEventList]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerEventList]];
             }];
}

- (EventListInteractor *)interactorEventList {
    return [TyphoonDefinition withClass:[EventListInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                        with:[self presenterEventList]];
                                [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(eventPrototypeMapper)
                                                      with:[self.serviceComponents eventPrototypeMapper]];
             }];
}

- (EventListPresenter *)presenterEventList {
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

- (EventListDataDisplayManager *)dataDisplayManagerEventList {
    return [TyphoonDefinition withClass:[EventListDataDisplayManager class]];
}

#pragma mark - TabBarButtonPrototypeProtocol

// добавить картинки
- (id<TabBarButtonPrototypeProtocol>)eventListTabBarButtonPrototype {
    return [TyphoonDefinition withClass:[TabBarButtonPrototype class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(tabBarButtonIdleStateImage)
                                                    with:[UIImage imageNamed:@""]];
                              [definition injectProperty:@selector(tabBarButtonSelectedStateImage)
                                                    with:[UIImage imageNamed:@""]];
                              [definition injectProperty:@selector(tabBarButtonTitle)
                                                    with:@"Анонсы"];
                              [definition injectProperty:@selector(tabbarButtonId)
                                                    with:@"events_tab"];
                              [definition injectProperty:@selector(tabBarControllercontent)
                                                    with:[self eventListTabBarControllerContent]];
                          }];
}

- (id<TabBarControllerContent>)eventListTabBarControllerContent {
    return [TyphoonFactoryDefinition withFactory:[self newsListStoryboard]
                                        selector:@selector(instantiateViewControllerWithIdentifier:)
                                      parameters:^(TyphoonMethod *factoryMethod) {
                                          [factoryMethod injectParameterWith:@"EventListTableViewController"];
                                      } configuration:^(TyphoonFactoryDefinition *definition) {
                                      }];
}

- (UIStoryboard*)newsListStoryboard {
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:kEventListStoryboardName];
                                                  [initializer injectParameterWith:self];
                                                  [initializer injectParameterWith:nil];
                                              }];
                          }];
}

@end