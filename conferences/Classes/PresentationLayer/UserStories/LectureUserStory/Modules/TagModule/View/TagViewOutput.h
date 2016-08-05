//
//  TagViewOutput.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TagViewOutput <NSObject>

/**
 @author Golovko Mikhail
 
 Метод вызвыается, когда на вью была нажата кнопка добавить тег
 */
- (void)didTriggerTapAddButton;

/**
 @author Golovko Mikhail
 
 Метод вызвыается, когда был нажа тег
 
 @param name Имя тега
 */
- (void)didTriggerTapTagWithName:(NSString *)name;

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда была нажата кнопка удалить тег
 
 @param name Имя тега
@param index Индекс тега
 */
- (void)didTriggerTapRemoveTagWithName:(NSString *)name
                               atIndex:(NSInteger)index;

@end