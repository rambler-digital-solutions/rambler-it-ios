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

@protocol SearchViewInput <NSObject>

/**
 @author Egor Tolstoy
 
 Method is used to inform View about initial setup
 
 @param suggests Suggests array
 */
- (void)setupViewWithSuggests:(NSArray *)suggests;

/**
 @author Egor Tolstoy
 
 MEthod is used to update a search edit field with a specific text
 
 @param text Search text
 */
- (void)updateSearchBarWithText:(NSString *)text;
- (void)startEditingSearchBar;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform View that SearchModuleView should be hidden
 */
- (void)hideSearchModuleView;

/**
 @author Zinovyev Konstantin
 
 Method is used to inform View that SearchModuleView should be shown
 */
- (void)showSearchModuleView;

@end

