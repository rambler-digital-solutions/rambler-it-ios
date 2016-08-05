//
//  TableViewCellAssembly.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 11/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellAssembly <NSObject>

- (void)inject:(UITableViewCell *)cell withSelector:(SEL)selector;

@end
