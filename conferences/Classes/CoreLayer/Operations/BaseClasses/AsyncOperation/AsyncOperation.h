//
//  AsyncOperation.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncOperation : NSOperation

/**
 @author Egor Tolstoy
 
 При старте операции метод вызывается в отдельном потоке. необходимо переопределить.
 */
- (void)main;

/**
 @author Egor Tolstoy
 
 Метод выставляет флаги о завершении операции, обязательно нужно вызвать по завершении.
 */
- (void)complete;

@end
