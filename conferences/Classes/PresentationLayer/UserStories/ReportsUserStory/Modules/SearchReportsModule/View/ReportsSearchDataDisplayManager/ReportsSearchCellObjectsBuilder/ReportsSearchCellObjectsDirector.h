//
//  ReportsSearchCellObjectsDirector.h
//  Conferences
//
//  Created by k.zinovyev on 25.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportsSearchCellObjectsDirector <NSObject>

- (NSArray *)generateCellObjectsFromPlainObjects:(NSArray *)plainObjects selectedText:(NSString *)selectedText;

@end

