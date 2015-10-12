//
//  RootViewInput.h
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import <Foundation/Foundation.h>
#import "BaseViewInput.h"

/**
 
 */
@protocol RootViewInput <BaseViewInput>

- (void)showTabs:(NSArray*)tabs;

@end

