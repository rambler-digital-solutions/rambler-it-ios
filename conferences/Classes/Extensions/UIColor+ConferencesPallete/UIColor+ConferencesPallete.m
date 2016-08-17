// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIColor+ConferencesPallete.h"
#import "UIColor+Hex.h"

@implementation UIColor (ConferencesPallete)

+ (UIColor *)rcf_yellowColor {
    return [UIColor colorFromHexString:@"#ffd000"];
}

+ (UIColor *)rcf_blackColor {
    return [UIColor colorFromHexString:@"#000000"];
}

+ (UIColor *)rcf_separatorColor {
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
}

+ (UIColor *)rcf_greyColor {
    return [UIColor colorFromHexString:@"#A0A0A0"];
}

+ (UIColor *)rcf_darkGrayColor {
    return [UIColor colorFromHexString:@"#5A5A5A"];
}

+ (UIColor *)rcf_lightGrayColor {
    return [UIColor colorFromHexString:@"#CDCDCD"];
}

+ (UIColor *)rcf_lightGrayBackgroundColor {
    return [UIColor colorFromHexString:@"#ECECEC"];
}


+ (UIColor *)rcf_lightBlueColor {
    return [UIColor colorFromHexString:@"#14AAE6"];
}

+ (UIColor *)rcf_blueColor {
    return [UIColor colorFromHexString:@"#0019FF"];
}

+ (UIColor *)rcf_greenColor {
    return [UIColor colorFromHexString:@"#5EC251"];
}

+ (UIColor *)rcf_darkGreenColor {
    return [UIColor colorFromHexString:@"#238C5F"];
}

+ (UIColor *)rcf_redColor {
    return [UIColor colorFromHexString:@"#FF3A44"];
}

+ (UIColor *)rcf_orangeColor {
    return [UIColor colorFromHexString:@"#FF7846"];
}

+ (UIColor *)rcf_purpleColor {
    return [UIColor colorFromHexString:@"#804EFF"];
}

@end
