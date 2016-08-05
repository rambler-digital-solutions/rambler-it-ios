//
// ContentSizeObserver.h
// LiveJournal
// 
// Created by Golovko Mikhail on 25/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContentSizeObserverDelegate;

/**
 @author Golovko Mikhail
 
 Класс для отслеживания размеров контента вьюшки, и уведолении об их изменении.
 */
@interface ContentSizeObserver : NSObject

/**
 @author Golovko Mikhail
 
 Вьшка, размеры которой нужно отслеживать.
 */
@property (nonatomic, strong) IBOutlet UIView *observerView;

/**
 @author Golovko Mikhail
 
 Делегат.
 */
@property (nonatomic, weak) id<ContentSizeObserverDelegate> delegate;

@end

@protocol ContentSizeObserverDelegate

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда размеры вьюшки поменялись.
 
 @param observer Отправитель.
 @param view     Вьюшка, чей размер контента поменялся.
 */
- (void)contentSizeObserver:(ContentSizeObserver *)observer viewDidChangeContentSize:(UIView *)view;

@end