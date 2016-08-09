//
// TagEditMediatorOutput.h
// LiveJournal
// 
// Created by Golovko Mikhail on 21/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TagEditMediatorOutput <NSObject>

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда нужно отобразить модуль выбора тега.
 */
- (void)showChooseTagModule;

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда нужно скрыть модуль выбора тега.
 */
- (void)hideChooseTagModule;

@end