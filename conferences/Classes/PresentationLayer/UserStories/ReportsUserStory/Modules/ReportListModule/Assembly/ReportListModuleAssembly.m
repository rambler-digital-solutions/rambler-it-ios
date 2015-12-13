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

#import "ReportListModuleAssembly.h"
#import "ReportListTableViewController.h"
#import "ReportListInteractor.h"
#import "ReportListPresenter.h"
#import "ReportListRouter.h"
#import "ReportListDataDisplayManager.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"

#import "TabBarButtonPrototype.h"

static NSString *const kReportsUserStoryName = @"EventsUserStory";
static NSString *const kTabBarButtonTitle = @"Отчеты";
static NSString *const kTabbarButtonId = @"reports_tab";

@implementation  ReportListModuleAssembly

- (ReportListTableViewController *)viewReportList {
    return [TyphoonDefinition withClass:[ReportListTableViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterReportList]];
                                [definition injectProperty:@selector(dataDisplayManager)
                                                      with:[self dataDisplayManagerReportList]];
             }];
}

- (ReportListInteractor *)interactorReportList {
    return [TyphoonDefinition withClass:[ReportListInteractor class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterReportList]];
                                [definition injectProperty:@selector(eventService)
                                                      with:[self.serviceComponents eventService]];
                                [definition injectProperty:@selector(eventPrototypeMapper)
                                                      with:[self.serviceComponents eventPrototypeMapper]];
                                [definition injectProperty:@selector(eventTypeDeterminator)
                                                      with:[self.presentationLayerHelpersAssembly eventTypeDeterminator]];
             }];
}

- (ReportListPresenter *)presenterReportList {
    return [TyphoonDefinition withClass:[ReportListPresenter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(view)
                                                      with:[self viewReportList]];
                                [definition injectProperty:@selector(interactor)
                                                      with:[self interactorReportList]];
                                [definition injectProperty:@selector(router)
                                                      with:[self routerReportList]];
            }];
}

- (ReportListRouter *)routerReportList {
    return [TyphoonDefinition withClass:[ReportListRouter class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(transitionHandler)
                                                      with:[self viewReportList]];
           }];
}

- (ReportListDataDisplayManager *)dataDisplayManagerReportList {
    return [TyphoonDefinition withClass:[ReportListDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(dateFormatter)
                                                    with:[self.presentationLayerHelpersAssembly dateFormatter]];
    }];
}

#pragma mark - TabBarButtonPrototypeProtocol

- (id<TabBarButtonPrototypeProtocol>)reportListTabBarButtonPrototype {
    return [TyphoonDefinition withClass:[TabBarButtonPrototype class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(tabBarButtonIdleStateImage)
                                                    with:[UIImage imageNamed:@""]];
                              [definition injectProperty:@selector(tabBarButtonSelectedStateImage)
                                                    with:[UIImage imageNamed:@""]];
                              [definition injectProperty:@selector(tabBarButtonTitle)
                                                    with:kTabBarButtonTitle];
                              [definition injectProperty:@selector(tabbarButtonId)
                                                    with:kTabbarButtonId];
                              [definition injectProperty:@selector(tabBarControllercontent)
                                                    with:[self reportListTabBarControllerContent]];
                          }];
}

- (id<TabBarControllerContent>)reportListTabBarControllerContent {
    return [TyphoonFactoryDefinition withFactory:[self reportListStoryboard]
                                        selector:@selector(instantiateViewControllerWithIdentifier:)
                                      parameters:^(TyphoonMethod *factoryMethod) {
                                          [factoryMethod injectParameterWith:NSStringFromClass([ReportListTableViewController class])];
                                      } configuration:^(TyphoonFactoryDefinition *definition) {
                                      }];
}

- (UIStoryboard*)reportListStoryboard {
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:kReportsUserStoryName];
                                                  [initializer injectParameterWith:self];
                                                  [initializer injectParameterWith:nil];
                                              }];
                          }];
}


@end