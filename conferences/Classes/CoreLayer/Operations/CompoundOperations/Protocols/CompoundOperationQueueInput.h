//
//  CompoundOperationQueueInput.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 Протокол, которым закрывается объект, способный обработать входные данные для старта очереди операций
 */
@protocol CompoundOperationQueueInput <NSObject>

/**
 @author Egor Tolstoy
 
 Метод устанавливает стартовые данные для очереди операций
 
 @param inputData Данные любого типа (могут быть и массивом, и словарем, и кастомной моделью). Приведение типов и интерпретация лежат на плечах конкретных подопераций.
 */
- (void)setOperationQueueInputData:(id)inputData;

@end
