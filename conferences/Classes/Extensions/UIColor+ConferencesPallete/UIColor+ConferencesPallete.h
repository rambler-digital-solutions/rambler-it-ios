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
 
 Category contains custom colors
 */
@interface UIColor (ConferencesPallete)

/**
 @author Zinovyev Konstantin
 
 The color of the selected text in the search events in the Reports section
 
 @return color
 */
+ (UIColor *)colorForSelectedTextEventCellObject;

/**
 @author Zinovyev Konstantin
 
 The color of the selected text in the search lectures in the Reports section
 
 @return color
 */
+ (UIColor *)colorForSelectedTextLectureCellObject;

/**
 @author Zinovyev Konstantin
 
 The color of the selected text in the search speakers in the Reports section
 
 @return color
 */
+ (UIColor *)colorForSelectedTextSpeakerCellObject;

@end
