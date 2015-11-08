//
//  CDResponderTableViewCell.h
//  Класс ячейки, которая по тапу находит ближайшую
//  view способную стать респондером.
//
//  Created by Smal Vadim on 23.04.15.
//  Copyright (c) 2015 Smal Vadim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDResponderTableViewCell : UITableViewCell


/**
 *  @author Vadim Smal
 *
 *  Классы которые могут быть респондерами.
 *  UITextField, UITextView, UIWebView
 *
 *  Метод для переопределения.
 */
- (NSArray *)responderClasses;

@end
