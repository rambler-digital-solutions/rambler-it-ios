//
//  RootRouter.h
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import <Foundation/Foundation.h>
#import "BaseRouter.h"
#import "RootRouterInput.h"

@protocol TabBarControllerContentEmbedder;

/**
 
 */
@interface RootRouter : BaseRouter <RootRouterInput>

@property (nonatomic,weak) id<TabBarControllerContentEmbedder> tabBarControllerContentEmbedder;

@property (nonatomic,strong) NSArray *tabFactories;

@end