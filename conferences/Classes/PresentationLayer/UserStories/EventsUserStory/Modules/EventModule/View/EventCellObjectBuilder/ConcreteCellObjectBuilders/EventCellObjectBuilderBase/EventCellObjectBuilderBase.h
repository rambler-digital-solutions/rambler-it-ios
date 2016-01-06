//
//  EventCellObjectBuilderBase.h
//  Conferences
//
//  Created by Karpushin Artem on 06/12/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EventPlainObject;
@class DateFormatter;

@interface EventCellObjectBuilderBase : NSObject

@property (strong, nonatomic) DateFormatter *dateFormatter;

- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event;

@end
