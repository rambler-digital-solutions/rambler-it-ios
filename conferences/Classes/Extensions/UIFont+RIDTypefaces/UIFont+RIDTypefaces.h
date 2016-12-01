//
//  UIFont+RIDTypefaces.h
//  Conferences
//
//  Created by k.zinovyev on 01.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @author Konstantin Zinovyev
 
 Категория определяет список шрифтов, используемых в приложении
 */
@interface UIFont (RIDTypefaces)

/**
 @author Konstantin Zinovyev

 System 24
*/
+ (UIFont *)rid_lectureTitleFont;

/**
 @author Konstantin Zinovyev
 
 System Semibold 16
 */
+ (UIFont *)rid_lectureDescriptionFont;


@end
