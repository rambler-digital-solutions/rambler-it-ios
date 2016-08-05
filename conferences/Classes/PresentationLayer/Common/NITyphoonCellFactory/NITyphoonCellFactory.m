//
//  NITyphoonCellFactory.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 11/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

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
