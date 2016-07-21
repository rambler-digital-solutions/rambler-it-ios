//
//  UIColor+ConferencesPallete.m
//  Conferences
//
//  Created by k.zinovyev on 19.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "UIColor+ConferencesPallete.h"
#import "UIColor+Hex.h"

static NSString *const kColorHexEvent = @"#ff0000";
static NSString *const kColorHexLecture = @"#00ff00";
static NSString *const kColorHexSpeaker = @"#0000ff";

@implementation UIColor (ConferencesPallete)

+ (UIColor *)colorForSelectedTextEventCellObject {
    return [UIColor colorFromHexString:kColorHexEvent];
}

+ (UIColor *)colorForSelectedTextLectureCellObject {
    return [UIColor colorFromHexString:kColorHexLecture];
}

+ (UIColor *)colorForSelectedTextSpeakerCellObject {
    return [UIColor colorFromHexString:kColorHexSpeaker];
}

@end
