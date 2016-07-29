//
//  AnnounceViewModelBuilder.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 25/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "AnnounceViewModelBuilder.h"
#import "EventPlainObject.h"
#import "AnnouncementViewModel.h"
#import "DateFormatter.h"

@implementation AnnounceViewModelBuilder

- (NSArray *)buildWithEvents:(NSArray *)events {
    NSMutableArray *viewModels = [NSMutableArray new];
    for (EventPlainObject *event in events) {
        NSString *date = [self.dateFormatter obtainDateWithDayMonthFormat:event.startDate];
        NSString *time = [self.dateFormatter obtainDateWithTimeFormat:event.startDate];
        AnnouncementViewModel *viewModel = [AnnouncementViewModel objectWithEvent:event
                                                                        eventDate:date
                                                                             time:time];
        [viewModels addObject:viewModel];
    }
    
    return [viewModels copy];
}

@end
