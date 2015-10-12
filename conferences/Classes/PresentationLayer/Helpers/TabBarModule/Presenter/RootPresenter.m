//
//  RootPresenter.m
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import "RootPresenter.h"
#import "RootViewInput.h"
#import "RootInteractorInput.h"
#import "RootRouterInput.h"

@interface RootPresenter()

@end

@implementation RootPresenter

#pragma mark - RootModuleConfigurator

/**
 Настройка модуля
 */
- (void)configureModule {

}

#pragma mark - RootViewOutput

- (void)setupView {
    [self.interactor getTabs];
}
- (void)selectedTabWithIndex:(NSUInteger)tabIndex {
    [self.router openTabWithIndex:tabIndex];
}

#pragma mark - RootInteractorOutput

- (void)showTabs:(NSArray*)tabs {
    [self.view showTabs:tabs];
    [self.router openTabWithIndex:0];
}

@end