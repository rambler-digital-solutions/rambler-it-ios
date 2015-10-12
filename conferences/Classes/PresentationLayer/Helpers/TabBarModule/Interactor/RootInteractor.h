//
//  RootInteractor.h
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import <Foundation/Foundation.h>
#import "BaseInteractor.h"
#import "RootInteractorInput.h"

@class TabsDDM;
@protocol RootInteractorOutput;

/**
 
 */
@interface RootInteractor : BaseInteractor <RootInteractorInput>

@property (nonatomic,strong) NSArray *tabs;
@property (nonatomic, weak) id<RootInteractorOutput> output;

@end

