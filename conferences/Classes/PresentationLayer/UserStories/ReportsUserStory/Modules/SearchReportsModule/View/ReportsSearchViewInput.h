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
 
 Initial setup view
 */
- (void)setupView;

/**
 @author Zinovyev Konstantin
 
 Method updates objects in module by found object after search
 
 @param foundObjects list found objects
 @param searchText   text in search bar
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

