//
//  CompoundOperationBase.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "CompoundOperationQueueInput.h"
#import "CompoundOperationQueueOutput.h"
#import "ChainableOperationDelegate.h"
#import "ChainableOperation.h"

typedef void(^CompoundOperationResultBlock)(id data, NSError *error);

/**
 @author Egor Tolstoy
 
 Базовый класс для Compound-операции. Не предназначен для использования напрямую.
 */
@interface CompoundOperationBase : AsyncOperation <ChainableOperationDelegate>

/**
 @author Egor Tolstoy
 
 Свойство, указывающее, какое количество операций может выполняться параллельно.
 Используется в случае наличия связок 1-ко-многим.
 */
@property (assign, nonatomic) NSUInteger maxConcurrentOperationsCount;

/**
 @author Egor Tolstoy
 
 Блок, который будет выполнен по завершении операции.
 */
@property (copy, nonatomic) CompoundOperationResultBlock resultBlock;

/**
 @author Egor Tolstoy
 
 Буфер для связи compound-операции и первой операции в очереди
 С его помощью мы можем передать в обработку какие-то данные (к примеру, письмо, которое надо отправить)
 */
@property (strong, nonatomic) id<CompoundOperationQueueInput> queueInput;

/**
 @author Egor Tolstoy
 
 Буфер для связи последней операции в очереди и compound-операции
 С его помощью мы можем получить результат выполнения всей последовательности операций
 */
@property (strong, nonatomic) id<CompoundOperationQueueOutput> queueOutput;

/**
 @author Egor Tolstoy
 
 Метод добавляет переданную ему операцию во внутреннюю очередь
 */
- (void)addOperation:(NSOperation <ChainableOperation> *)operation;

@end
