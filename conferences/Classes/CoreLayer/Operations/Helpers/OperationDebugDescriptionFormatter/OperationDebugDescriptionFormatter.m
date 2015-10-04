//
//  OperationDebugDescriptionFormatter.m
//  Conferences
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "OperationDebugDescriptionFormatter.h"

#import "ChainableOperation.h"

@implementation OperationDebugDescriptionFormatter

+ (NSString *)debugDescriptionForOperation:(NSOperation <ChainableOperation> *)operation
                        withAdditionalInfo:(NSArray *)additionalInfo {
    NSMutableString *debugDescription = [[NSMutableString alloc] init];
    
    // Общая информация
    [debugDescription appendString:@"====================================\n"];
    [debugDescription appendString:@"Класс операции:\n"];
    [debugDescription appendString:[NSString stringWithFormat:@"- %@\n", NSStringFromClass([operation class])]];
    [debugDescription appendString:@"====================================\n"];
    
    // Описание входных данных
    id inputData = [operation.input obtainInputDataWithTypeValidationBlock:nil];
    if (inputData) {
        [debugDescription appendString:@"Входные данные:\n"];
        [debugDescription appendString:[NSString stringWithFormat:@"- Тип: %@;\n", NSStringFromClass([inputData class])]];
        [debugDescription appendString:[NSString stringWithFormat:@"- Содержание: %@;\n", inputData]];
    } else {
        [debugDescription appendString:@"Нет входных данных\n"];
    }
    [debugDescription appendString:@"====================================\n"];
    
    // Описание зависимостей на другие операции
    if (operation.dependencies.count > 0) {
        [debugDescription appendString:@"Зависит от:\n"];
        [operation.dependencies enumerateObjectsUsingBlock:^(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            NSString *dependencyDescription = [NSString stringWithFormat:@"%li: %@, isExecuting: %i\n", idx, NSStringFromClass([obj class]), obj.isExecuting];
            [debugDescription appendString:dependencyDescription];
        }];
    } else {
        [debugDescription appendString:@"Нет зависимостей на другие операции\n"];
    }
    [debugDescription appendString:@"====================================\n"];
    
    // Флажки
    [debugDescription appendString:@"Состояние:\n"];
    [debugDescription appendString:[NSString stringWithFormat:@"- isExecuting: %i;\n", operation.isExecuting]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isFinished: %i;\n", operation.isFinished]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isCancelled: %i;\n", operation.isCancelled]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isReady: %i;\n", operation.isReady]];
    [debugDescription appendString:[NSString stringWithFormat:@"- isAsynchronous: %i;\n", operation.isAsynchronous]];
    [debugDescription appendString:@"====================================\n"];
    
    // Дополнительная информация
    [debugDescription appendString:@"Дополнительная информация:\n"];
    for (NSString *infoString in additionalInfo) {
        [debugDescription appendString:infoString];
        [debugDescription appendString:@"\n"];
    }
    
    return [debugDescription copy];
}

@end
