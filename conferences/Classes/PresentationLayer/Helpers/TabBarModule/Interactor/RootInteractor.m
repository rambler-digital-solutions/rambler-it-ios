//
//  RootInteractor.m
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import "RootInteractor.h"
#import "RootInteractorOutput.h"

@interface RootInteractor()

@end

@implementation RootInteractor

#pragma mark - RootInteractorInput

- (void)getTabs {
    [self.output showTabs:self.tabs];
}

@end