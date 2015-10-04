//
//  ChainableOperationOutput.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 Протокол объекта, принимающего результат работы под-операции
 */
@protocol ChainableOperationOutput <NSObject>

/**
 @author Egor Tolstoy
 
 Метод спередает результат работы текущей операции
 
 @param outputData Результат работы операции
 */
- (void)didCompleteChainableOperationWithOutputData:(id)outputData;

@end
