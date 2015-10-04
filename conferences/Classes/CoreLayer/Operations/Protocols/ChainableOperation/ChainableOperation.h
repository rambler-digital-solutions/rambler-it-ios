//
//  ChainableOperation.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChainableOperationInput.h"
#import "ChainableOperationOutput.h"
#import "ChainableOperationDelegate.h"
#import "OperationDebugDescriptionFormatter.h"

/**
 @author Egor Tolstoy
 
 Протокол операции, предназначенной для работы в цепочке compound-операции
 */
@protocol ChainableOperation <NSObject>

/**
 @author Egor Tolstoy
 
 Делегат, которому операция при необходимости сообщает о своем выполнении
 */
@property (weak, nonatomic) id<ChainableOperationDelegate> delegate;

/**
 @author Egor Tolstoy
 
 Источник входных данных для операции
 */
@property (strong, nonatomic) id<ChainableOperationInput> input;

/**
 @author Egor Tolstoy
 
 Место, куда операция положит результат своей работы
 */
@property (strong, nonatomic) id<ChainableOperationOutput> output;

@end
