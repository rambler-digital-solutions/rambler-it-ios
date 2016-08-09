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

#import "NITyphoonCellFactory.h"
#import "NITyphoonInjectableCell.h"

#import <Typhoon/Typhoon.h>

#import <Nimbus/NICellFactory+Private.h>

@implementation NITyphoonCellFactory

+ (UITableViewCell *)cellWithClass:(Class)cellClass
                         tableView:(UITableView *)tableView
                            object:(id)object {
    UITableViewCell* cell = nil;
    
    NSString* identifier = NSStringFromClass(cellClass);
    
    if ([cellClass respondsToSelector:@selector(shouldAppendObjectClassToReuseIdentifier)]
        && [cellClass shouldAppendObjectClassToReuseIdentifier]) {
        identifier = [identifier stringByAppendingFormat:@".%@", NSStringFromClass([object class])];
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        UITableViewCellStyle style = UITableViewCellStyleDefault;
        if ([object respondsToSelector:@selector(cellStyle)]) {
            style = [object cellStyle];
        }
        cell = [[cellClass alloc] initWithStyle:style reuseIdentifier:identifier];
    }
    
    [self configureInjectableCellIfNeeded:cell];
    
    if ([cell respondsToSelector:@selector(shouldUpdateCellWithObject:)]) {
        [(id<NICell>)cell shouldUpdateCellWithObject:object];
    }
    
    return cell;
}

+ (UITableViewCell *)cellWithNib:(UINib *)cellNib
                       tableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath
                          object:(id)object {
    UITableViewCell* cell = nil;

    NSString* identifier = NSStringFromClass([object class]);

    cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        NSArray *nib = [cellNib instantiateWithOwner:nil
                                             options:nil];
        cell = (UITableViewCell *)[nib objectAtIndex:0];

        [self configureInjectableCellIfNeeded:cell];
    }


    if ([cell respondsToSelector:@selector(shouldUpdateCellWithObject:)]) {
        [(id<NICell>)cell shouldUpdateCellWithObject:object];
    }

    return cell;
}

+ (void)configureInjectableCellIfNeeded:(UITableViewCell *)cell {
    if (cell.restorationIdentifier != nil && [cell conformsToProtocol:@protocol(NITyphoonInjectableCell)]) {
        id<NITyphoonInjectableCell> injectableCell = (id<NITyphoonInjectableCell>)cell;
        BOOL isCellConfigured = [injectableCell isConfigured];
        if (!isCellConfigured) {
            TyphoonComponentFactory *factory = [TyphoonComponentFactory factoryForResolvingUI];
            [factory inject:cell
               withSelector:NSSelectorFromString(cell.restorationIdentifier)];
            [injectableCell setIsConfigured:YES];
        }        
    }
}

@end
