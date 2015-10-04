//
//  OperationDebugDescriptionFormatter.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChainableOperation;

/**
 @author Egor Tolstoy
 
 Объект, реализующий общую логику вывода debugDescription для всех чейнящихся операций
 */
@interface OperationDebugDescriptionFormatter : NSObject

/**
 @author Egor Tolstoy
 
 Метод отдает строку с описанием любой ChainableOperation. В описание входят:
 - Класс операции
 - Описание входных данных из буфера
 - Описание зависимостей на другие операции
 - Состояние операции (флажки)
 - Переданные методу дополнительные данные
 
 @param operation      ChainableOperation
 @param additionalInfo Дополнительные данные, специфичные для конкретной операции
 
 @return Отформатированная строка для вывода в консоль
 */
+ (NSString *)debugDescriptionForOperation:(NSOperation <ChainableOperation> *)operation
                        withAdditionalInfo:(NSArray *)additionalInfo;

@end
