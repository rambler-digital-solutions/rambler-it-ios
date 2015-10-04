//
//  CompoundOperationDebugDescriptionFormatter.h
//  Conferences
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CompoundOperationBase;

/**
 @author Egor Tolstoy
 
 Объект подготавливает описание CompoundOperation для вывода его в консоль
 */
@interface CompoundOperationDebugDescriptionFormatter : NSObject

/**
 @author Egor Tolstoy
 
 Метод отдает строку с описанием CompoundOperation. В описание входят:
 - Общая информация:
   - Класс операции
   - Имя внутренней очереди
   - Количество операций во внутренней очереди
   - Максимально возможное количество параллельных операций
 - Информация о буферах:
   - Тип входных данных
   - Содержимое входных данных
   - Тип выходных данных
   - Содержимое выходных данных
 - Зависимости от других операций
 - Состояние:
   - Состояние внутренней очереди
   - Состояние флажков compound-операции
 - Дополнительная информация:
   - Наличие resultBlock
 - Информация о выполняемых операциях в настоящий момент:
   - Класс каждой выполняемой операции
   - Собственный debugDescription каждой выполняемой операции
 
 @param compoundOperation CompoundOperationBase
 @param internalQueue     Внутренняя очередь compound-операции
 
 @return Отформатированная строка с описанием
 */
+ (NSString *)debugDescriptionForCompoundOperation:(CompoundOperationBase *)compoundOperation
                                 withInternalQueue:(NSOperationQueue *)internalQueue;

@end
