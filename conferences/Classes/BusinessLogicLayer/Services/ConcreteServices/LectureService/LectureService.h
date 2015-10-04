//
//  LectureService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class Lecture;

typedef void (^LectureCompletionBlock)(Lecture *lecture, NSError *error);

@protocol LectureService <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain Lecture object from cache
 
 @param predicate NSPredicate for specifying the filtering parameters
 
 @return Lecture object
 */
- (Lecture *)obtainLectureWithPredicate:(NSPredicate *)predicate;

/**
 @author Artem Karpushin
 
 Method is used to update Lecture object by sending request to server
 
 @param predicate NSPredicate for specifying the filtering parameters
 @param completionBlock LectureCompletionBlock called upon completion the method, and returns Lecture object and NSError object if there is any
 */
- (void)updateLectureWithPredicate:(NSPredicate *)predicate completionBlock:(LectureCompletionBlock)completionBlock;

@end
