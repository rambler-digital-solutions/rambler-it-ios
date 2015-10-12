//
//  RootViewController.h
//  Проект:   Championat
//
//  Модуль:   Root
//  Описание: Главный модуль приложения
//
//  Создан Andrey Zarembo-Godzyatsky  11/08/15
//  Rambler DS 2015
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RootViewInput.h"
#import "TabBarControllerContentEmbedder.h"

@protocol RootViewOutput;

/**
 
 */
@interface RootViewController : BaseViewController <RootViewInput,TabBarControllerContentEmbedder>

@property (nonatomic, strong) id<RootViewOutput> output;

@property (nonatomic, weak) IBOutlet UICollectionView *tabButtonsCollectionView;
@property (nonatomic, weak) IBOutlet UIView *contentContainerView;

@end

