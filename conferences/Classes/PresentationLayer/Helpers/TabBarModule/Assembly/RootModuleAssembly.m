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

#import "RamblerLocationModuleAssembly.h"
#import "EventListModuleAssembly.h"

@interface  RootModuleAssembly()

@property (nonatomic,strong,readonly) EventListModuleAssembly *eventListModuleAssembly;
@property (nonatomic,strong,readonly) RamblerLocationModuleAssembly *ramblerLocationModuleAssembly;

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
    return @[
             [self.eventListModuleAssembly eventListTabBarButtonPrototype],
             [self.ramblerLocationModuleAssembly ramblerLocationTabBarButtonPrototype],
             ];
}

@end