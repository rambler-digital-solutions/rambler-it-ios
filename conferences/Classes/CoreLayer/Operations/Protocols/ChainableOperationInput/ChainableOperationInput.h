//
//  ChainableOperationInput.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^ChainableOperationInputTypeValidationBlock)(id data);

/**
 @author Egor Tolstoy
 
 Протокол источника данных операции
 */
@protocol ChainableOperationInput <NSObject>

/**
 @author Egor Tolstoy
 
 Метод возвращает стартовые данные (если они есть), необходимые для выполнения операции
 
 @param block Блок валидации типа данных
 
 @return Данные любого типа, прошедшие валидацию
 */
- (id)obtainInputDataWithTypeValidationBlock:(ChainableOperationInputTypeValidationBlock)block;

@end
