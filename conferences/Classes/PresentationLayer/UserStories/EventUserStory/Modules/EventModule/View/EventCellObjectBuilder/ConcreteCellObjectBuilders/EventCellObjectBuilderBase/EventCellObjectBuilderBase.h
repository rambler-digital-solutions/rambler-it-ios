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
@class EventPlainObject;

@interface EventCellObjectBuilderBase : NSObject

@property (strong, nonatomic) DateFormatter *dateFormatter;

- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event
                      pastEvents:(NSArray *)pastEvents;

- (NSArray *)cellObjectsForLectureSectionWithEvent:(EventPlainObject *)event;

- (NSArray *)cellObjectsForPastEventsSectionWithCurrentEvent:(EventPlainObject *)event
                                                  pastEvents:(NSArray *)pastEvents;

- (NSArray *)cellObjectsForPastLecturesSectionWithCurrentEvent:(EventPlainObject *)event
                                                    pastEvents:(NSArray *)pastEvents;
@end
