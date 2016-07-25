//
//  ReportsSearchCellObjectsBuilder.h
//  Conferences
//
//  Created by k.zinovyev on 25.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReportEventTableViewCellObject;
@class ReportLectureTableViewCellObject;
@class ReportSpeakerTableViewCellObject;

@class LecturePlainObject;
@class EventPlainObject;
@class SpeakerPlainObject;

@protocol ReportsSearchCellObjectsBuilder <NSObject>

/**
 @author Zinovyev Konstantin
 
 Method generates event cell object from event plain object
 
 @param event        plain object
 @param selectedText text, that need select by custom color
 
 @return event cell object
 */
- (ReportEventTableViewCellObject *)eventCellObjectFromPlainObject:(EventPlainObject *)event selectedText:(NSString *)selectedText;

/**
 @author Zinovyev Konstantin
 
 Method generates lecture cell object from event plain object
 
 @param event        plain object
 @param selectedText text, that need select by custom color
 
 @return lecture cell object
 */
- (ReportLectureTableViewCellObject *)lectureCellObjectFromPlainObject:(LecturePlainObject *)lecture selectedText:(NSString *)selectedText;

/**
 @author Zinovyev Konstantin
 
 Method generates speaker cell object from event plain object
 
 @param event        plain object
 @param selectedText text, that need select by custom color
 
 @return speaker cell object
 */
- (ReportSpeakerTableViewCellObject *)speakerCellObjectFromPlainObject:(SpeakerPlainObject *)speaker selectedText:(NSString *)selectedText;

@end

