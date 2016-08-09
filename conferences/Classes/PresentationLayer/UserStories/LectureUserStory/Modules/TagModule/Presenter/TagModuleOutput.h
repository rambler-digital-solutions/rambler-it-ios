//
// TagModuleOutput.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TagModuleOutput <NSObject>

/**
 @author Golovko Mikhail

 Методы не обязательные, так как в зависимости от настроек модуля не все методы
 нужно реализовывать.
 */
@optional

/**
 @author Golovko Mikhail
 
 Метод вызвается, когда была нажата кнопка добавить тег
 */
- (void)didTapAddButton;

/**
 @author Golovko Mikhail
 
 Метод вызвается, когда был нажат тег
 
 @param name Имя тега
 */
- (void)didTapTagWithName:(NSString *)name;

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда был удалён тег
 
 @param name Имя тега
 */
- (void)didRemoveTagWithName:(NSString *)name;

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда модуль отобразил пустое состояние.
 */
- (void)didShowEmptyState;

@end