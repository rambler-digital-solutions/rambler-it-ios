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
 
 The facade is designed to work with different services for obtain some objects. e.g. Events/Speakers/Lectures
 */
@protocol SearchFacade <NSObject>

/**
 @author Surik Sarkisyan
 
 Method is used to obtain Event objects array from storage
 
 @param predicates array for specifying the filtering parameters
 
 @return Event objects array
 */
- (NSArray *)eventsForPredicates:(NSArray<NSPredicate *> *)predicates;

/**
 @author Surik Sarkisyan
 
 Method is used to obtain Speaker objects array from storage
 
 @param predicates array for specifying the filtering parameters
 
 @return Speaker objects array
 */
- (NSArray *)speakersForPredicates:(NSArray<NSPredicate *> *)predicates;

/**
 @author Surik Sarkisyan
 
 Method is used to obtain Lectures objects array from storage
 
 @param predicates array for specifying the filtering parameters
 
 @return Lectures objects array
 */
- (NSArray *)lecturesForPredicates:(NSArray<NSPredicate *> *)predicates;

@end
