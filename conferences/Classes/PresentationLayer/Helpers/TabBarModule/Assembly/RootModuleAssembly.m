//
//  RootModuleAssembly.m
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import "RootModuleAssembly.h"
#import "RootViewController.h"
#import "RootInteractor.h"
#import "RootPresenter.h"
#import "RootRouter.h"

#import "TabBarButtonPrototype.h"

#import "NewsListModuleAssembly.h"
#import "MyFeedModuleAssembly.h"
#import "MatchesListModuleAssembly.h"
#import "StatsSportSelectorModuleAssembly.h"


@interface  RootModuleAssembly()

@property (nonatomic,strong,readonly) NewsListModuleAssembly *newsListModuleAssembly;
@property (nonatomic,strong,readonly) MyFeedModuleAssembly   *myFeedModuleAssembly;
@property (nonatomic,strong,readonly) MatchesListModuleAssembly *matchesListModuleAssembly;
@property (nonatomic,strong,readonly) StatsSportSelectorModuleAssembly *statsSportSelectorModuleAssembly;

@end

@implementation  RootModuleAssembly

- (RootViewController *)viewRoot {
    return [TyphoonDefinition withParent:[self.baseModuleComponentsAssembly baseViewController]
                                   class:[RootViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRoot]];
                            [definition injectProperty:@selector(moduleConfigurator) 
                                                  with:[self presenterRoot]];
                            
             }];
}

- (RootInteractor *)interactorRoot {
    return [TyphoonDefinition withParent:[self.baseModuleComponentsAssembly baseInteractor]
                                   class:[RootInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(output) 
                                                  with:[self presenterRoot]];
                              [definition injectProperty:@selector(tabs)
                                                    with:[self tabs]];
             }];
}

- (RootPresenter *)presenterRoot {
    return [TyphoonDefinition withClass:[RootPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(view) 
                                                  with:[self viewRoot]];                                            
                            [definition injectProperty:@selector(interactor) 
                                                  with:[self interactorRoot]];
                            [definition injectProperty:@selector(router) 
                                                  with:[self routerRoot]];
            }];
}

- (RootRouter *)routerRoot {
    return [TyphoonDefinition withParent:[self.baseModuleComponentsAssembly baseRouter]
                                   class:[RootRouter class]
                           configuration:^(TyphoonDefinition *definition) {
                               [definition injectProperty:@selector(transitionHandler)
                                                     with:[self viewRoot]];
                               [definition injectProperty:@selector(tabBarControllerContentEmbedder)
                                                     with:[self viewRoot]];
                               [definition injectProperty:@selector(tabFactories)
                                                     with:[self tabs]];
                           }];                                   
}

- (NSArray *)tabs {
    return @[[self.newsListModuleAssembly newsListTabBarButtonPrototype],
             [self.myFeedModuleAssembly myFeedTabBarButtonPrototype],
             [self.matchesListModuleAssembly matchesListTabBarButtonPrototype],
             [self.statsSportSelectorModuleAssembly statisticsTabBarButtonPrototype]
             ];
}

@end