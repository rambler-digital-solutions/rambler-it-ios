//
//  RCMResignFirstResponderHandler.h
//  Mail
//
//  Created by Smal Vadim on 23/09/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Vadim Smal
 
 Протокол объекта, который хочет узнать о потери фокуса в текстовом поле ячейки.
 Используется для выставления фокуса в следующию ячейку.
 */

@protocol RCMResignFirstResponderHandler <NSObject>

/**
 @author Vadim Smal
 
 Метод сообщает о том, что поле ввода в ячейка потеря фокус.
 
 @param sender ячейка
 */
- (void)tableViewCellDidResignFirstResponder:(UITableViewCell *)sender;

@end
