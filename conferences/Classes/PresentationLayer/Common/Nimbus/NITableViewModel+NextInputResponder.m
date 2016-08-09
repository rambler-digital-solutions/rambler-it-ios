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

#import "NITableViewModel+NextInputResponder.h"
#import <NITableViewModel+Private.h>
#import "NextInputResponder.h"

@implementation NITableViewModel (NextInputResponder)

#pragma mark - Публичные методы

- (NSIndexPath *)nextInputResponderIndexPathForIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *resultIndexPath;
    resultIndexPath = [self nextIndexPathForIndexPath:indexPath];
    
    return resultIndexPath;
}

#pragma mark - Приватные методы

- (NSIndexPath *)nextIndexPathForIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentSection = indexPath.section;
    NSInteger currentRow = indexPath.row;
    
    NSArray *sections = self.sections;
    for (NSInteger sectionIndex = currentSection; sectionIndex < sections.count; sectionIndex ++) {
        NSArray *rows = [sections[sectionIndex] rows];
        NSInteger rowIndex = (sectionIndex == currentSection) ? currentRow + 1 : 0;
        for (; rowIndex < rows.count; rowIndex++) {
            
            id <NextInputResponder> nextObject = rows[rowIndex];
            if ([nextObject respondsToSelector:@selector(canBecomeNextInputResponder)]) {
                return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            }
        }
    }
    
    return nil;
}

@end
