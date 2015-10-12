//
//  RamblerLocationModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "RamblerLocationModuleAssembly.h"
#import "RamblerLocationViewController.h"
#import "RamblerLocationInteractor.h"
#import "RamblerLocationPresenter.h"
#import "RamblerLocationRouter.h"

#import "TabBarButtonPrototype.h"

static NSString * const kRamblerLocationStoryboardName = @"RamblerLocationUserStory";

@implementation  RamblerLocationModuleAssembly

- (RamblerLocationViewController *)viewRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRamblerLocation]];
             }];
}

- (RamblerLocationInteractor *)interactorRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRamblerLocation]];
             }];
}

- (RamblerLocationPresenter *)presenterRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(view) 
                                                  with:[self viewRamblerLocation]];                                            
                            [definition injectProperty:@selector(interactor) 
                                                  with:[self interactorRamblerLocation]];
                            [definition injectProperty:@selector(router) 
                                                  with:[self routerRamblerLocation]];
            }];
}

- (RamblerLocationRouter *)routerRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationRouter class]
                          configuration:^(TyphoonDefinition *definition) {

           }];
}

#pragma mark - TabBarButtonPrototypeProtocol

// добавить картинки
- (id<TabBarButtonPrototypeProtocol>)ramblerLocationTabBarButtonPrototype {
    return [TyphoonDefinition withClass:[TabBarButtonPrototype class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(tabBarButtonIdleStateImage)
                                                    with:[UIImage imageNamed:@"news"]];
                              [definition injectProperty:@selector(tabBarButtonSelectedStateImage)
                                                    with:[UIImage imageNamed:@"news_sel"]];
                              [definition injectProperty:@selector(tabBarButtonTitle)
                                                    with:@"Схема проезда"];
                              [definition injectProperty:@selector(tabbarButtonId)
                                                    with:@"location_tab"];
                              [definition injectProperty:@selector(tabBarControllercontent)
                                                    with:[self ramblerLocationTabBarControllerContent]];
                          }];
}

- (id<TabBarControllerContent>)ramblerLocationTabBarControllerContent {
    return [TyphoonFactoryDefinition withFactory:[self ramblerLocationStoryboard]
                                        selector:@selector(instantiateViewControllerWithIdentifier:)
                                      parameters:^(TyphoonMethod *factoryMethod) {
                                          [factoryMethod injectParameterWith:@"RamblerLocationViewController"];
                                      } configuration:^(TyphoonFactoryDefinition *definition) {
                                      }];
}

- (UIStoryboard*)ramblerLocationStoryboard {
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:kRamblerLocationStoryboardName];
                                                  [initializer injectParameterWith:self];
                                                  [initializer injectParameterWith:nil];
                                              }];
                          }];
}

@end