//
//  ReportsSearchDataDisplayManager.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DataDisplayManager.h"

@class EventPlainObject;
@class LecturePlainObject;
@class SpeakerPlainObject;
@class DateFormatter;

@protocol ReportSearchDataDisplayManagerDelegate

- (void)didUpdateTableViewModel;
- (void)didTapCellWithEvent:(EventPlainObject *)event;
- (void)didTapCellWithLecture:(LecturePlainObject *)event;
- (void)didTapCellWithSpeaker:(SpeakerPlainObject *)event;

@end

@interface ReportsSearchDataDisplayManager : NSObject <DataDisplayManager>


@property (weak, nonatomic) id <ReportSearchDataDisplayManagerDelegate> delegate;
@property (strong, nonatomic) DateFormatter *dateFormatter;

- (void)configureDataDisplayManagerWithObjects:(NSArray *)foundObjects;
- (void)updateTableViewModelWithObjects:(NSArray *)foundObjects searchText:(NSString *)searchText;


@end
