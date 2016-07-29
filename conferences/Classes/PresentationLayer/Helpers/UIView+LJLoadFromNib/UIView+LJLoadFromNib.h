//
//  UIView+LJLoadFromNib.h
//  LiveJournal
//
//  Created by Smal Vadim on 30/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @author Vadim Smal
 
 Вспомогательная категория для загрузки вью из ксиба
 */
@interface UIView (LJLoadFromNib)

/**
 @author Vadim Smal
 
 Загружает вью из ксиба по классу вью
 
 @return UIView
 */
+ (instancetype)loadFromNib;

/**
 @author Vadim Smal
 
 Загружает вью из ксиба по имени ксиба
 
 @param nibName имя ксиба
 
 @return UIView
 */
+ (instancetype)loadFromNibWithName:(NSString *)nibName;

@end
