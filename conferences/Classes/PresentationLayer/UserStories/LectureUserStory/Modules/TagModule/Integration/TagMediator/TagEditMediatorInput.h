//
// TagEditMediatorInput.h
// LiveJournal
// 
// Created by Golovko Mikhail on 24/03/16.
// Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TagChooseModuleInput;
@class TagObjectDescriptor;

/**
 @author Golovko Mikhail

 Протокол описывающий интерфейс медиатора, который используется для управления
 модулем редактирования тегов (TagChooseModuleInput).
 */
@protocol TagEditMediatorInput <NSObject>

/**
 @author Golovko Mikhail
 
 Метод конфигурирует медиатор.
 
 @param tagChooseModuleInput Модуль редактирования тегов.
 */
- (void)configureModuleWithChooseModuleInput:(id<TagChooseModuleInput>)tagChooseModuleInput;

/**
 @author Golovko Mikhail
 
 Метод сообщает о том, что объект для выбора саджестов был изменён.
 
 @param objectDescriptor Информация об объекте.
 */
- (void)updateWithSuggestObjectDescriptor:(TagObjectDescriptor *)objectDescriptor;

@end