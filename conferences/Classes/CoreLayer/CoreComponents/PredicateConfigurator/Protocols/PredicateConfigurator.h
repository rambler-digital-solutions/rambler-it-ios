// Copyright (c) 2016 RAMBLER&Co
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

/**
 @author Surik Sarkisyan
 
 The configurator is designed to constract predicates for further usage in services.
 */
@protocol PredicateConfigurator <NSObject>

/**
 @author Surik Sarkisyan
 
 Method is used to constract predicates for event objects filter
 
 @param string wich typed by user
 
 @return predicates array configured from input string
 */
- (NSArray<NSPredicate *> *)configureEventsPredicatesForSearchText:(NSString *)searchText;

/**
 @author Surik Sarkisyan
 
 Method is used to constract predicates for speaker objects filter
 
 @param string wich typed by user
 
 @return predicates array configured from input string
 */
- (NSArray<NSPredicate *> *)configureSpeakersPredicatesForSearchText:(NSString *)searchText;

/**
 @author Surik Sarkisyan
 
 Method is used to constract predicates for lecture objects filter
 
 @param string wich typed by user
 
 @return predicates array configured from input string
 */
- (NSArray<NSPredicate *> *)configureLecturesPredicatesForSearchText:(NSString *)searchText;

@end
