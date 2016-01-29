// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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

- (id<TabBarButtonPrototypeProtocol>)ramblerLocationTabBarButtonPrototype {
    return [TyphoonDefinition withClass:[TabBarButtonPrototype class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(tabBarButtonIdleStateImage)
                                                    with:[UIImage imageNamed:@"light-gray-square"]];
                              [definition injectProperty:@selector(tabBarButtonSelectedStateImage)
                                                    with:[UIImage imageNamed:@"light-gray-square"]];
                              [definition injectProperty:@selector(tabBarButtonTitle)
                                                    with:@"Как проехать"];
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