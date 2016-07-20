// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DataDisplayManager.h"

@class EventPlainObject;
@class DateFormatter;

@protocol ReportListDataDisplayManagerDelegate

/**
 @author Zinovyev Konstantin
 
 Метод сообщает делегату о законечнном обновлении tableViewModel
 */
- (void)didUpdateTableViewModel;

/**
 @author Zinovyev Konstantin
 
 Метод сообщает делегату о нажатии на ячейку, содержащую объект event
 
 @param event Событие, которое находится в нажатой ячейке
 */
- (void)didTapCellWithEvent:(EventPlainObject *)event;

@end

@interface ReportListDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <ReportListDataDisplayManagerDelegate> delegate;
@property (strong, nonatomic) DateFormatter *dateFormatter;

/**
 @author Zinovyev Konstantin
 
 Метод отвечающий за первоначальную конфигурацию DDM
 
 @param events Список событий
 */
- (void)configureDataDisplayManagerWithEvents:(NSArray *)events;

/**
 @author Zinovyev Konstantin
 
 Метод обновляющий TableViewModel новыми событиями
 
 @param events Список событий
 */
- (void)updateTableViewModelWithEvents:(NSArray *)events;

@end
