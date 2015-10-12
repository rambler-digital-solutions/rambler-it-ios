//
//  RootRouter.m
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import "RootRouter.h"
#import "TabBarButtonPrototypeProtocol.h"
#import "TabBarControllerContentEmbedder.h"
#import "TabBarControllerEmbeddedContentConfigurator.h"

@interface RootRouter()

@property (nonatomic,strong) NSMutableDictionary *contentCache;

@end

@implementation RootRouter

#pragma mark - RootRouterInput

- (instancetype)init {
    self = [super init];
    if (self) {
        _contentCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)openTabWithIndex:(NSUInteger)tabIndex {
    id<TabBarButtonPrototypeProtocol> prototype = self.tabFactories[tabIndex];
    
    id<TabBarControllerContent> content = self.contentCache[[prototype tabbarButtonId]];
    if (content == nil) {
        content = [prototype tabBarControllercontent];
    }
    [[self.tabBarControllerContentEmbedder embedContent:content]
     thenConfigureModuleWithBlock:^(id<TabBarControllerEmbeddedContentConfigurator> rccModuleConfigurator) {
         [rccModuleConfigurator configureWithTagBarButtonId:[prototype tabbarButtonId]];
    }];
}

@end