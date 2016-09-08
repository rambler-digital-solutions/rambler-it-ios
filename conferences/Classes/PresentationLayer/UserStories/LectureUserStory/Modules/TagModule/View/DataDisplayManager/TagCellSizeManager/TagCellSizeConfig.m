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

#import "TagCellSizeConfig.h"
#import "TagModuleViewConstants.h"

@implementation TagCellSizeConfig

- (instancetype)initWithContentWidth:(CGFloat)contentWidth
                         itemSpacing:(CGFloat)itemSpacing
                         itemHeight:(CGFloat)itemHeight
                       itemSideInset:(CGFloat)itemSideInset
                         font:(UIFont *)font {
    self = [super init];
    if (self) {
        _contentWidth = contentWidth;
        _itemSpacing = itemSpacing;
        _itemSideInset = itemSideInset;
        _font = font;
        _itemHeight = itemHeight;
        
    }

    return self;
}


+ (instancetype)defaultConfig {

    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = CGRectGetWidth(screenRect);
    CGFloat contentWidth = screenWidth - kLeftContentSpacing - kRightContentSpacing;
    UIFont *font = [UIFont fontWithName:kNameFontTagText size:kSizeFontTagText];
    
    TagCellSizeConfig *config = [[TagCellSizeConfig alloc] initWithContentWidth:contentWidth
                                                                    itemSpacing:kItemSpacing
                                                                     itemHeight:kItemHeight
                                                                  itemSideInset:kSideItemInset
                                                                           font:font];


    return config;
}


@end