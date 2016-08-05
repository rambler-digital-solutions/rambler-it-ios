//
// TagModuleConfig.h
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TagObjectDescriptor;

/**
 @author Golovko Mikhail
 
 Класс конфигурации модуля отображения тегов.
 */
@interface TagModuleConfig : NSObject

/**
 @author Golovko Mikhail

 Конфигурация объекта, с которым будет работать модуль тегов.
 */
@property (nonatomic, strong) TagObjectDescriptor *objectDescriptor;

/**
 @author Golovko Mikhail

 Конфигурация объекта, теги которого не нужно отображать в выборке.
 */
@property (nonatomic, strong) TagObjectDescriptor *filteredObjectDescriptor;

/**
 @author Golovko Mikhail
 
 Режим отображения
 YES - вертикальный
 NO - горизонтальный
 */
@property (assign, nonatomic) BOOL verticalAlign;

/**
 @author Golovko Mikhail
 
 Флаг отображения кнопки добавления тегов
 */
@property (assign, nonatomic) BOOL enableAddButton;

/**
 @author Golovko Mikhail
 
 Флаг отображения кнопки удаления тега
 */
@property (assign, nonatomic) BOOL enableRemoveButton;

/**
 @author Golovko Mikhail
 
 Количество строк, которые отображаются в свернутом режиме.
 TagModuleDisableCollapseTags - не будет сворачиваться.
 */
@property (assign, nonatomic) NSInteger numberOfShowLine;

- (instancetype)initWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor;

- (instancetype)initWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                filteredObjectDescriptor:(TagObjectDescriptor *)filteredObjectDescriptor;


@end
