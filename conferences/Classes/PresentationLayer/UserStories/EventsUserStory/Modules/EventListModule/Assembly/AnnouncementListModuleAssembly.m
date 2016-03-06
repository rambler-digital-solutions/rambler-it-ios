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

#import "AnnouncementListModuleAssembly.h"
#import "AnnouncementListTableViewController.h"
#import "AnnouncementListInteractor.h"
#import "AnnouncementListPresenter.h"
#import "AnnouncementListRouter.h"
#import "AnnouncementListDataDisplayManager.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"

#import "TabBarButtonPrototype.h"

static NSString *const kEventsStoryboardName = @"EventsUserStory";
static NSString *const kTabBarButtonTitle = @"Анонсы";
static NSString *const kTabbarButtonId = @"events_tab";

@implementation  AnnouncementListModuleAssembly

- (AnnouncementListTableViewController *)viewAnnouncementList {
    return [TyphoonDefinition withClass:[AnnouncementListTableViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterAnnouncementList]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerAnnouncementList]];
             }];
}

- (AnnouncementListInteractor *)interactorAnnouncementList {
    return [TyphoonDefinition withClass:[AnnouncementListInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                        with:[self presenterAnnouncementList]];
                                [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(eventPrototypeMapper)
                                                      with:[self.serviceComponents eventPrototypeMapper]];
             }];
}

- (AnnouncementListPresenter *)presenterAnnouncementList {
    return [TyphoonDefinition withClass:[AnnouncementListPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(view) 
                                                  with:[self viewAnnouncementList]];                                            
                            [definition injectProperty:@selector(interactor) 
                                                  with:[self interactorAnnouncementList]];
                            [definition injectProperty:@selector(router) 
                                                  with:[self routerAnnouncementList]];
            }];
}

- (AnnouncementListRouter *)routerAnnouncementList {
    return [TyphoonDefinition withClass:[AnnouncementListRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewAnnouncementList]];
           }];
}

- (AnnouncementListDataDisplayManager *)dataDisplayManagerAnnouncementList {
    return [TyphoonDefinition withClass:[AnnouncementListDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
    }];
}

#pragma mark - TabBarButtonPrototypeProtocol

- (id<TabBarButtonPrototypeProtocol>)announcementListTabBarButtonPrototype {
    return [TyphoonDefinition withClass:[TabBarButtonPrototype class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(tabBarButtonIdleStateImage)
                                                    with:[UIImage imageNamed:@"light-gray-square"]];
                              [definition injectProperty:@selector(tabBarButtonSelectedStateImage)
                                                    with:[UIImage imageNamed:@"light-gray-square"]];
                              [definition injectProperty:@selector(tabBarButtonTitle)
                                                    with:kTabBarButtonTitle];
                              [definition injectProperty:@selector(tabbarButtonId)
                                                    with:kTabbarButtonId];
                              [definition injectProperty:@selector(tabBarControllercontent)
                                                    with:[self announcementListTabBarControllerContent]];
                          }];
}

- (id<TabBarControllerContent>)announcementListTabBarControllerContent {
    return [TyphoonFactoryDefinition withFactory:[self announcementListStoryboard]
                                        selector:@selector(instantiateViewControllerWithIdentifier:)
                                      parameters:^(TyphoonMethod *factoryMethod) {
                                          [factoryMethod injectParameterWith:NSStringFromClass([AnnouncementListTableViewController class])];
                                      } configuration:^(TyphoonFactoryDefinition *definition) {
                                      }];
}

- (UIStoryboard*)announcementListStoryboard {
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:kEventsStoryboardName];
                                                  [initializer injectParameterWith:self];
                                                  [initializer injectParameterWith:nil];
                                              }];
                          }];
}

@end