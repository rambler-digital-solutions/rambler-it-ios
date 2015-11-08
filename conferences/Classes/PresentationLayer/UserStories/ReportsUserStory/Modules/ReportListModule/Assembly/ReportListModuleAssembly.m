//
//  ReportListModuleAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "ReportListModuleAssembly.h"
#import "ReportListTableViewController.h"
#import "ReportListInteractor.h"
#import "ReportListPresenter.h"
#import "ReportListRouter.h"

#import "TabBarButtonPrototype.h"

static NSString * const kReportsUserStoryName = @"ReportsUserStory";

@implementation  ReportListModuleAssembly

- (ReportListTableViewController *)viewReportList {
    return [TyphoonDefinition withClass:[ReportListTableViewController class]
                            configuration:^(TyphoonDefinition *definition) {
                                [definition injectProperty:@selector(output)
                                                      with:[self presenterReportList]];
             }];
}

- (ReportListInteractor *)interactorReportList {
    return [TyphoonDefinition withClass:[ReportListInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterReportList]];
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

           }];
}

#pragma mark - TabBarButtonPrototypeProtocol

// добавить картинки
- (id<TabBarButtonPrototypeProtocol>)reportListTabBarButtonPrototype {
    return [TyphoonDefinition withClass:[TabBarButtonPrototype class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(tabBarButtonIdleStateImage)
                                                    with:[UIImage imageNamed:@""]];
                              [definition injectProperty:@selector(tabBarButtonSelectedStateImage)
                                                    with:[UIImage imageNamed:@""]];
                              [definition injectProperty:@selector(tabBarButtonTitle)
                                                    with:@"Отчеты"];
                              [definition injectProperty:@selector(tabbarButtonId)
                                                    with:@"reports_tab"];
                              [definition injectProperty:@selector(tabBarControllercontent)
                                                    with:[self reportListTabBarControllerContent]];
                          }];
}

- (id<TabBarControllerContent>)reportListTabBarControllerContent {
    return [TyphoonFactoryDefinition withFactory:[self reportListStoryboard]
                                        selector:@selector(instantiateViewControllerWithIdentifier:)
                                      parameters:^(TyphoonMethod *factoryMethod) {
                                          [factoryMethod injectParameterWith:@"ReportListTableViewController"];
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