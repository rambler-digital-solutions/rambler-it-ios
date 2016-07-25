//
//  ReportsSearchCellObjectsBuilder.m
//  Conferences
//
//  Created by k.zinovyev on 25.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchCellObjectsBuilderImplementation.h"

#import "LecturePlainObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"

#import "ReportEventTableViewCellObject.h"
#import "ReportSpeakerTableViewCellObject.h"
#import "ReportLectureTableViewCellObject.h"

#import "DateFormatter.h"

@implementation ReportsSearchCellObjectsBuilderImplementation

- (instancetype)initWithDateFormatter:(DateFormatter *)dateFormatter {
    self = [super init];
    if (self) {
        _dateFormatter = dateFormatter;
    }
    return self;
}

- (ReportEventTableViewCellObject *)eventCellObjectFromPlainObject:(EventPlainObject *)event selectedText:(NSString *)selectedText {

    NSString *eventDate = [self.dateFormatter obtainDateWithDayMonthYearFormat:event.startDate];
    
    ReportEventTableViewCellObject *cellObject = [ReportEventTableViewCellObject objectWithEvent:event andDate:eventDate selectedText:selectedText];
    return cellObject;
}

- (ReportLectureTableViewCellObject *)lectureCellObjectFromPlainObject:(LecturePlainObject *)lecture selectedText:(NSString *)selectedText {
    ReportLectureTableViewCellObject *cellObject = [ReportLectureTableViewCellObject objectWithLecture:lecture selectedText:selectedText];
    return cellObject;
}

- (ReportSpeakerTableViewCellObject *)speakerCellObjectFromPlainObject:(SpeakerPlainObject *)speaker selectedText:(NSString *)selectedText {
    ReportSpeakerTableViewCellObject *cellObject = [ReportSpeakerTableViewCellObject objectWithSpeaker:speaker selectedText:selectedText];
    return cellObject;
}

@end
