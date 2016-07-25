//
//  ReportsSearchCellObjectsDirector.h
//  Conferences
//
//  Created by k.zinovyev on 25.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportsSearchCellObjectsDirector <NSObject>

/**
 @author Zinovyev Konstantin
 
 Method generates array cell objects from arrays plain object
 
 @param plainObjects        plain objects
 @param selectedText text, that need select by custom color
 
 @return cell objects
 */
- (NSArray *)generateCellObjectsFromPlainObjects:(NSArray *)plainObjects selectedText:(NSString *)selectedText;

@end

