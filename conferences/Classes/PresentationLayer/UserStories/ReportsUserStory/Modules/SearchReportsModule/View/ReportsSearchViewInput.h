//
//  ReportsSearchViewInput.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportsSearchViewInput <NSObject>

/**
 @author Zinovyev Konstantin
 
 Первоначальная настройка view
 */
- (void)setupView;

/**
 @author Zinovyev Konstantin
 
 Метод обновляющий список найденных событий
 
 @param events Список событий
 */
- (void)updateViewWithObjectList:(NSArray *)foundObjects searchText:(NSString *)searchText;

/**
 @author Zinovyev Konstantin
 
 Метод отвечает за показ прозрачного экрана, при пустой строке поиска
 */
- (void)showClearPlaceholder;

/**
 @author Zinovyev Konstantin
 
 Метод отвечает за скрытие поиска с экрана 
 */
- (void)closeSearchView;

@end

