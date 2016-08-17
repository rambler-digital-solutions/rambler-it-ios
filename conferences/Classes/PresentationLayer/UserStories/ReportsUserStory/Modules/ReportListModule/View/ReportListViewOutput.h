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

@class EventPlainObject;

@protocol ReportListViewOutput <NSObject>

/**
 @author Zinovyev Konstantin
 
 Method is used to inform presenter that need setup the view
 */
- (void)setupView;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform presenter that cell was tapped
 
 @param event Event in tapped cell
 */
- (void)didTriggerTapCellWithEvent:(EventPlainObject *)event;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform presenter that user has change the search text
 
 @param text Text in search bar
 */
- (void)didChangeSearchBarWithSearchTerm:(NSString *)text;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform presenter that user has tapped the cancel button
 */
- (void)didTapSearchBarCancelButton;

/**
 @author Egor Tolstoy
 
 Method tells presenter that a suggest was tapped
 
 @param text Suggest text
 */
- (void)didTapSuggestWithText:(NSString *)text;

@end

