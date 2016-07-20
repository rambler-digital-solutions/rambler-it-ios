//
//  UIColor+ConferencesPallete.h
//  Conferences
//
//  Created by k.zinovyev on 19.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @author Zinovyev Konstantin
 
 Категория, в которой зашиты дефолтные цвета
 */
@interface UIColor (ConferencesPallete)

/**
 @author Zinovyev Konstantin
 
 Цвет выделенного текста при поиске событий в разделе Отчеты
 
 @return Цвет
 */
+ (UIColor *)colorForSelectedTextEventCellObject;

/**
 @author Zinovyev Konstantin
 
 Цвет выделенного текста при поиске докладов в разделе Отчеты
 
 @return Цвет
 */
+ (UIColor *)colorForSelectedTextLectureCellObject;

/**
 @author Zinovyev Konstantin
 
 Цвет выделенного текста при поиске докладчиков в разделе Отчеты
 
 @return Цвет
 */
+ (UIColor *)colorForSelectedTextSpeakerCellObject;

@end
