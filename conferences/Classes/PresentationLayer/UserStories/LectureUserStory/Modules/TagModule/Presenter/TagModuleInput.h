//
//  TagModuleInput.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry.h>

@protocol TagModuleOutput;
@class TagModuleConfig;

@protocol TagModuleInput <RamblerViperModuleInput>

/**
 @author Golovko Mikhail

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureModuleWithModuleConfig:(TagModuleConfig *)moduleConfig
                           moduleOutput:(id <TagModuleOutput>)moduleOutput;

/**
 @author Golovko Mikhail
 
 Метод обновляет модуль для поиска по тексту.
 
 @param searchText Текст поиска.
 */
- (void)updateModuleWithSearchText:(NSString *)searchText;

/**
 @author Golovko Mikhail
 
 Метод отображает кнопку добавить тег
 */
- (void)showAddButton;

/**
 @author Golovko Mikhail
 
 Метод скрывает кнопку добавить тег
 */
- (void)hideAddButton;

/**
 @author Golovko Mikhail
 
 Метод добавляет тег
 
 @param name Имя тега
 */
- (void)addTagWithName:(NSString *)name;

@end