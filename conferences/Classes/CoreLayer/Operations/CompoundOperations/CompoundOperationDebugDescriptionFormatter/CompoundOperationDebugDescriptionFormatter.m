//
//  CompoundOperationDebugDescriptionFormatter.m
//  Conferences
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "CompoundOperationDebugDescriptionFormatter.h"

#import "CompoundOperationBase.h"
#import "OperationBuffer.h"

@implementation CompoundOperationDebugDescriptionFormatter

+ (NSString *)debugDescriptionForCompoundOperation:(CompoundOperationBase *)compoundOperation
                                 withInternalQueue:(NSOperationQueue *)internalQueue {
    NSMutableString *debugDescription = [NSMutableString new];
    
    // Общая информация
    [debugDescription appendString:@"====================================\n"];
    [debugDescription appendString:@"Общая информация:\n"];
    [debugDescription appendString:[NSString stringWithFormat:@"- Класс операции: %@\n", NSStringFromClass([compoundOperation class])]];
    [debugDescription appendString:[NSString stringWithFormat:@"- Имя внутренней очереди: %@\n", internalQueue.name]];
    [debugDescription appendString:[NSString stringWithFormat:@"- Операций в очереди: %li\n", internalQueue.operationCount]];
    [debugDescription appendString:[NSString stringWithFormat:@"- maxConcurrentOperationCount: %li\n", compoundOperation.maxConcurrentOperationsCount]];
    [debugDescription appendString:@"====================================\n"];
    
    // Буферы данных
    id inputData = [(OperationBuffer *)compoundOperation.queueInput obtainInputDataWithTypeValidationBlock:nil];
    id outputData = [compoundOperation.queueOutput obtainOperationQueueOutputData];
    if (inputData) {
        [debugDescription appendString:@"Входные данные:\n"];
        [debugDescription appendString:[NSString stringWithFormat:@"- Тип: %@;\n", NSStringFromClass([inputData class])]];
        [debugDescription appendString:[NSString stringWithFormat:@"- Содержание: %@;\n", inputData]];
    } else {
        [debugDescription appendString:@"Нет входных данных\n"];
    }
    if (outputData) {
        [debugDescription appendString:@"Выходные данные:\n"];
        [debugDescription appendString:[NSString stringWithFormat:@"- Тип: %@;\n", NSStringFromClass([outputData class])]];
        [debugDescription appendString:[NSString stringWithFormat:@"- Содержание: %@;\n", outputData]];
    } else {
        [debugDescription appendString:@"Нет выходных данных\n"];
    }
    [debugDescription appendString:@"====================================\n"];
    
    // Внешнее состояние
    [debugDescription appendString:@"Зависимости от других операций:\n"];
    if (compoundOperation.dependencies.count > 0) {
        [debugDescription appendString:@"Зависит от:\n"];
        [compoundOperation.dependencies enumerateObjectsUsingBlock:^(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            NSString *dependencyDescription = [NSString stringWithFormat:@"%li: %@, isExecuting: %i\n", idx, NSStringFromClass([obj class]), obj.isExecuting];
            [debugDescription appendString:dependencyDescription];
        }];
    } else {
        [debugDescription appendString:@"Нет зависимостей на другие операции\n"];
    }
    [debugDescription appendString:@"====================================\n"];\
    
    // Флажки
    [debugDescription appendString:@"Состояние:\n"];
    [debugDescription appendString:[NSString stringWithFormat:@"- isQueueSuspended: %i;\n", internalQueue.isSuspended]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isExecuting: %i;\n", compoundOperation.isExecuting]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isFinished: %i;\n", compoundOperation.isFinished]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isCancelled: %i;\n", compoundOperation.isCancelled]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isReady: %i;\n", compoundOperation.isReady]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isAsynchronous: %i;\n", compoundOperation.isAsynchronous]];
    [debugDescription appendString:@"====================================\n"];
    
    // Дополнительная информация
    [debugDescription appendString:@"Дополнительная информация:\n"];
    if (compoundOperation.resultBlock) {
        [debugDescription appendString:@"resultBlock установлен"];
    } else {
        [debugDescription appendString:@"resultBlock не установлен"];
    }
    [debugDescription appendString:@"====================================\n"];
    
    // Сейчас выполняется
    NSUInteger executingOperationsCount = 0;
    for (NSOperation *operation in internalQueue.operations) {
        if (operation.isExecuting) {
            executingOperationsCount += 1;
        }
    }
    [debugDescription appendString:[NSString stringWithFormat:@"Сейчас выполняется %li операций\n", executingOperationsCount]];
    if (executingOperationsCount > 0) {
        [internalQueue.operations enumerateObjectsUsingBlock:^(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            if (obj.isExecuting) {
                [debugDescription appendString:[NSString stringWithFormat:@"- Операция %li\n", idx]];
                [debugDescription appendString:[NSString stringWithFormat:@"  - Класс операции: %@\n", NSStringFromClass([obj class])]];
                [debugDescription appendString:@"  - Описание операции: \n"];
                [debugDescription appendString:@"\n{{{НАЧАЛО ОПИСАНИЯ ВЫПОЛНЯЕМОЙ ОПЕРАЦИИ}}}\n"];
                [debugDescription appendString:[obj debugDescription]];
                [debugDescription appendString:@"{{{ОКОНЧАНИЕ ОПИСАНИЯ ВЫПОЛНЯЕМОЙ ОПЕРАЦИИ}}}\n\n"];
            }
        }];
    }
    
    return [debugDescription copy];
}

@end
