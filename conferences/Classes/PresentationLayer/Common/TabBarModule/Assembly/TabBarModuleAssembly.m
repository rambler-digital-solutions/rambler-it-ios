
#import "TabBarModuleAssembly.h"
#import "TabBarViewController.h"
#import "TabBarInteractor.h"
#import "TabBarPresenter.h"
#import "TabBarRouter.h"

#import "TabBarButtonPrototype.h"

#import "RamblerLocationModuleAssembly.h"
#import "EventListModuleAssembly.h"
#import "ReportListModuleAssembly.h"

@interface  TabBarModuleAssembly()

@property (nonatomic, strong, readonly) EventListModuleAssembly *eventListModuleAssembly;
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
             [self.eventListModuleAssembly eventListTabBarButtonPrototype],
             [self.ramblerLocationModuleAssembly ramblerLocationTabBarButtonPrototype],
             [self.reportListModuleAssembly reportListTabBarButtonPrototype]
             ];
}

@end