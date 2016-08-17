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

#import "TagCellSizeRowCalculator.h"
#import "TagCellSizeConfig.h"

@interface TagCellSizeRowCalculator ()

@property (nonatomic, assign) CGFloat useWidth;
@property (nonatomic, assign, readwrite) NSInteger countRows;
@property (nonatomic, assign, readwrite) NSInteger countAddItems;

@end

@implementation TagCellSizeRowCalculator

- (instancetype)initWithConfig:(TagCellSizeConfig *)config {
    self = [super init];
    if (self) {
        _config = config;
    }

    return self;
}


- (void)addItemAtWidth:(CGFloat)itemWidth {
    if ([self addItemInSameRowAtWidth:itemWidth]) {
        return;
    }
    [self addNewRow];
    [self addItemInSameRowAtWidth:itemWidth];
}

- (BOOL)addItemInSameRowAtWidth:(CGFloat)itemWidth {

    if (self.countRows == 0) {
        return NO;
    }

    CGFloat freeWidth = self.config.contentWidth - self.useWidth;

    CGFloat fullItemWidth = itemWidth;

    if (self.useWidth != 0) {
        fullItemWidth += self.config.itemSpacing;
    }

    if (freeWidth < fullItemWidth) {
        return NO;
    }

    self.useWidth += fullItemWidth;
    self.countAddItems++;

    return YES;
}

- (void)cleanRows {
    self.useWidth = 0;
    self.countRows = 0;
    self.countAddItems = 0;
}

- (void)addNewRow {
    self.useWidth = 0;
    self.countRows++;
}

@end