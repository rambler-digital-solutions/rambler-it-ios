//
// TagObjectDescriptor.h
// LiveJournal
// 
// Created by Golovko Mikhail on 24/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 @author Golovko Mikhail

 Класс содержит информацию об объекте, с которым должен работать модуль тегов
 */
@interface TagObjectDescriptor : NSObject

/**
 @author Golovko Mikhail

 Имя объекта модели, с которым работать
 */
@property (nonatomic, strong, readonly) NSString *objectName;

/**
 @author Golovko Mikhail

 Значение поля идентификатора объекта модели
 */
@property (nonatomic, strong, readonly) NSString *idValue;

- (instancetype)initWithObjectName:(NSString *)objectName
                           idValue:(NSString *)idValue;


@end