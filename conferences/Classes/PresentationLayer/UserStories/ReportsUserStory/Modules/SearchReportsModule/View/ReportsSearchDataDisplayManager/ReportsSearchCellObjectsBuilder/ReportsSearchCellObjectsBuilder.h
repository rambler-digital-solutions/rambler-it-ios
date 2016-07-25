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

- (ReportEventTableViewCellObject *)eventCellObjectFromPlainObject:(EventPlainObject *)event selectedText:(NSString *)selectedText;
- (ReportLectureTableViewCellObject *)lectureCellObjectFromPlainObject:(LecturePlainObject *)lecture selectedText:(NSString *)selectedText;
- (ReportSpeakerTableViewCellObject *)speakerCellObjectFromPlainObject:(SpeakerPlainObject *)speaker selectedText:(NSString *)selectedText;

@end

