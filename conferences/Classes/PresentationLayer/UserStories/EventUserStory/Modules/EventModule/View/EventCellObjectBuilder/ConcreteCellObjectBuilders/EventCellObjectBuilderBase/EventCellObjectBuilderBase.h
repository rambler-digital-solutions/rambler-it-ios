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

/**
 @author Vasyura Anastasiya
 
 Build cell objects for event detailed tableview model
 
 @param event      current event
 @param pastEvents past events
 
 @return CellObjects
 */
- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event
                      pastEvents:(NSArray *)pastEvents;

/**
 @author Vasyura Anastasiya
 
 Build cellObjects for current event lectures section
 
 @param event current event
 
 @return Cellobjects
 */
- (NSArray *)cellObjectsForLectureSectionWithEvent:(EventPlainObject *)event;

/**
 @author Vasyura Anastasiya
 
 Build cellObjects for past events section
 
 @param event      currentEvent
 @param pastEvents past events
 
 @return CellObjects
 */
- (NSArray *)cellObjectsForPastEventsSectionWithCurrentEvent:(EventPlainObject *)event
                                                  pastEvents:(NSArray *)pastEvents;

/**
 @author Vasyura Anastasiya
 
 Build cellObjects for past lectures section
 
 @param event      current event
 @param pastEvents past events
 
 @return CellObjects
 */
- (NSArray *)cellObjectsForPastLecturesSectionWithCurrentEvent:(EventPlainObject *)event
                                                    pastEvents:(NSArray *)pastEvents;
@end
