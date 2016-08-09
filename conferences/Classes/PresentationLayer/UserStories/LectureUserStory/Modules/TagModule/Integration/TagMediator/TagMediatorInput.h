//
// TagMediatorInput.h
// LiveJournal
// 
// Created by Golovko Mikhail on 28/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TagObjectDescriptor;
@protocol TagModuleInput;

/**
 @author Golovko Mikhail

 Протокол описывающий интерфейс медиатора, который используется для управления
 модулем отображением тегов (TagModuleInput).
 */
@protocol TagMediatorInput <NSObject>

/**
 @author Golovko Mikhail
 
 Метод конфигурируем медиатор.
 
 @param objectDescriptor Инофмрация об редактируемом объекте.
 */
- (void)configureWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                       tagModuleInput:(id <TagModuleInput>)tagModuleInput;

@end
