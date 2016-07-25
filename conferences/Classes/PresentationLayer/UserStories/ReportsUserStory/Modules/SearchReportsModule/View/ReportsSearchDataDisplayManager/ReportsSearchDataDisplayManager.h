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
@protocol ReportsSearchCellObjectsDirector;

@protocol ReportSearchDataDisplayManagerDelegate

/**
 @author Zinovyev Konstantin
 
 Метод сообщает делегату о законечнном обновлении tableViewModel
 */
- (void)didUpdateTableViewModel;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает делегату о нажатии на ячейку, содержащую объект event
 
 @param event Объект события
 */
- (void)didTapCellWithEvent:(EventPlainObject *)event;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает делегату о нажатии на ячейку, содержащую объект доклада
 
 @param event Объект доклада
 */
- (void)didTapCellWithLecture:(LecturePlainObject *)event;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает делегату о нажатии на ячейку, содержащую объект докладчика
 
 @param event Объект докладчика
 */
- (void)didTapCellWithSpeaker:(SpeakerPlainObject *)event;

@end

@interface ReportsSearchDataDisplayManager : NSObject <DataDisplayManager>


@property (nonatomic, weak) id <ReportSearchDataDisplayManagerDelegate> delegate;
@property (nonatomic, strong) id<ReportsSearchCellObjectsDirector> director;
/**
 @author Zinovyev Konstantin
 
 Метод отвечающий за первоначальную конфигурацию DDM
 
 @param events Список событий
 */
- (void)configureDataDisplayManagerWithObjects:(NSArray *)foundObjects;

/**
 @author Zinovyev Konstantin
 
 Метод обновляющий TableViewModel новыми событиями
 
 @param events Список событий
 */
- (void)updateTableViewModelWithObjects:(NSArray *)foundObjects searchText:(NSString *)searchText;

- (instancetype)initWithCellObjectDirector:(id <ReportsSearchCellObjectsDirector>)director;

@end
