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

#import "TabBarModuleAssembly.h"
#import "TabBarViewController.h"
#import "TabBarInteractor.h"
#import "TabBarPresenter.h"
#import "TabBarRouter.h"

#import "TabBarButtonPrototype.h"

#import "RamblerLocationModuleAssembly.h"
#import "AnnouncementListModuleAssembly.h"
#import "ReportListModuleAssembly.h"

@interface  TabBarModuleAssembly()

@property (nonatomic, strong, readonly) AnnouncementListModuleAssembly *eventListModuleAssembly;
@property (nonatomic, strong, readonly) RamblerLocationModuleAssembly *ramblerLocationModuleAssembly;
@property (nonatomic, strong, readonly) ReportListModuleAssembly *reportListModuleAssembly;

@end

@implementation  TabBarModuleAssembly

- (TabBarViewController *)viewRoot {
    return [TyphoonDefinition withClass:[TabBarViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRoot]];
                            //[definition injectProperty:@selector(moduleConfigurator)
                                                 // with:[self presenterRoot]];
                            
             }];
}

- (TabBarInteractor *)interactorRoot {
    return [TyphoonDefinition withClass:[TabBarInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRoot]];
                              [definition injectProperty:@selector(tabs)
                                                    with:[self tabs]];
             }];
}

- (TabBarPresenter *)presenterRoot {
    return [TyphoonDefinition withClass:[TabBarPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(view) 
                                                  with:[self viewRoot]];                                            
                            [definition injectProperty:@selector(interactor) 
                                                  with:[self interactorRoot]];
                            [definition injectProperty:@selector(router) 
                                                  with:[self routerRoot]];
            }];
}

- (TabBarRouter *)routerRoot {
    return [TyphoonDefinition withClass:[TabBarRouter class]
                           configuration:^(TyphoonDefinition *definition) {
                              // [definition injectProperty:@selector(transitionHandler)
                                                   //  with:[self viewRoot]];
                               [definition injectProperty:@selector(tabBarControllerContentEmbedder)
                                                     with:[self viewRoot]];
                               [definition injectProperty:@selector(tabFactories)
                                                     with:[self tabs]];
                           }];                                   
}

- (NSArray *)tabs {
    return @[
             [self.eventListModuleAssembly announcementListTabBarButtonPrototype],
             [self.ramblerLocationModuleAssembly ramblerLocationTabBarButtonPrototype],
             [self.reportListModuleAssembly reportListTabBarButtonPrototype]
             ];
}

@end