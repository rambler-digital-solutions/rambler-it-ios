//
//  ReportsSearchInteractorInput.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportsSearchInteractorInput <NSObject>

/**
 @author Zinovyev Konstantin
 
 Методполучения список всех прошедших событий, отсортированных по дате и по предикату
 
 @return Массив событий
 */
- (NSArray *)obtainFoundObjectListWithSearchText:(NSString *)text;

@end

