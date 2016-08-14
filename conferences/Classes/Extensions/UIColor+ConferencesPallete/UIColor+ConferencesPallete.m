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

+ (UIColor *)LJ_black {
    return [UIColor colorFromHexString:@"#000000"];
}

+ (UIColor *)LJ_grey {
    return [UIColor colorFromHexString:@"#A0A0A0"];
}

+ (UIColor *)LJ_darkGray {
    return [UIColor colorFromHexString:@"#5A5A5A"];
}

+ (UIColor *)LJ_lightGray {
    return [UIColor colorFromHexString:@"#CDCDCD"];
}

+ (UIColor *)LJ_lightBlue {
    return [UIColor colorFromHexString:@"#14AAE6"];
}

+ (UIColor *)LJ_blue {
    return [UIColor colorFromHexString:@"#0019FF"];
}

+ (UIColor *)LJ_green {
    return [UIColor colorFromHexString:@"#5EC251"];
}

+ (UIColor *)LJ_darkGreen {
    return [UIColor colorFromHexString:@"#238C5F"];
}

+ (UIColor *)LJ_red {
    return [UIColor colorFromHexString:@"#FF3A44"];
}

+ (UIColor *)LJ_orange {
    return [UIColor colorFromHexString:@"#FF7846"];
}

+ (UIColor *)LJ_purple {
    return [UIColor colorFromHexString:@"#804EFF"];
}

+ (UIColor *)LJ_yellow {
    return [UIColor colorFromHexString:@"#FFD000"];
}

@end
