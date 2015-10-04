//
//  OperationBuffer.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChainableOperationInput.h"
#import "ChainableOperationOutput.h"
#import "CompoundOperationQueueInput.h"
#import "CompoundOperationQueueOutput.h"

/**
 @author Egor Tolstoy
 
 Класс-посредник между элементами выполнения логики compound-операции.
 
 Нужен для ослабления связи между двумя подоперациями, позволяет создавать любые комбинации из под-операций, ничего друг о друге не знающих.
 Кроме того, связывает compound-операцию с первой и последней операциями из очереди.
 */
@interface OperationBuffer : NSObject <ChainableOperationInput, ChainableOperationOutput, CompoundOperationQueueInput, CompoundOperationQueueOutput>

+ (instancetype)buffer;

@end
