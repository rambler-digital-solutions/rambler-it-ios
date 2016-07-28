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
@class TechPlainObject;

@interface EventCellObjectBuilderBase : NSObject

@property (strong, nonatomic) DateFormatter *dateFormatter;

- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event
                      pastEvents:(NSArray *)pastEvents;

@end
