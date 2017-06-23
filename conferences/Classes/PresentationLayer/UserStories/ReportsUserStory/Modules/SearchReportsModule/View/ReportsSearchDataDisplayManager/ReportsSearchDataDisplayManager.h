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
@class LecturePlainObject;
@class SpeakerPlainObject;
@class DateFormatter;
@protocol ReportsSearchCellObjectsDirector;

@protocol ReportSearchDataDisplayManagerDelegate

/**
 @author Zinovyev Konstantin
 
 Method is used to inform delegate that tableViewModel was updated
 */
- (void)didUpdateTableViewModel;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform delegate that event cell was tapped
 
 @param event Event object
 */
- (void)didTapCellWithEvent:(EventPlainObject *)event;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform delegate that lecture cell was tapped
 
 @param lecture Lecture object
 */
- (void)didTapCellWithLecture:(LecturePlainObject *)lecture;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform delegate that speaker cell was tapped
 
 @param speaker Speaker object
 */
- (void)didTapCellWithSpeaker:(SpeakerPlainObject *)speaker;

@end

@interface ReportsSearchDataDisplayManager : NSObject <DataDisplayManager>

@property (nonatomic, weak) id <ReportSearchDataDisplayManagerDelegate> delegate;
@property (nonatomic, strong) id<ReportsSearchCellObjectsDirector> director;

- (instancetype)initWithCellObjectDirector:(id <ReportsSearchCellObjectsDirector>)director;

/**
 @author Zinovyev Konstantin
 
 Method is used to update TableViewModel with new objects
 
 @param foundObjects Founded objects
 */
- (void)updateTableViewModelWithObjects:(NSArray *)foundObjects searchText:(NSString *)searchText;

@end
