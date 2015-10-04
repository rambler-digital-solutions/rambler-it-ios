//
//  ChainableOperationDelegate.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 Протокол делегата операции
 */
@protocol ChainableOperationDelegate <NSObject>

/**
 @author Egor Tolstoy
 
 Метод сообщает compound-операции (а именно она является делегатом) о том, что операция завершилась (либо успешно, либо с ошибкой). Что делать дальше - решать уже compound-операции.
 
 @param error Ошибка выполнения под-операции
 */
- (void)didCompleteChainableOperationWithError:(NSError *)error;

@end
