//
//  UIFont+RIDTypefaces.m
//  Conferences
//
//  Created by k.zinovyev on 01.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "UIFont+RIDTypefaces.h"

@implementation UIFont (RIDTypefaces)

+ (UIFont *)rid_lectureTitleFont {
    return [UIFont systemFontOfSize:24.0f
                             weight:UIFontWeightSemibold];
}

+ (UIFont *)rid_lectureDescriptionFont {
    return [UIFont systemFontOfSize:16.0f];
}

@end
