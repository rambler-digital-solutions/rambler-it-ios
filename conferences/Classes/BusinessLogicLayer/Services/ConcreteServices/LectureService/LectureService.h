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

- (Lecture *)obtainLectureWithPredicate:(NSPredicate *)predicate;

- (void)updateLectureWithPredicate:(NSPredicate *)predicate completionBlock:(LectureCompletionBlock)completionBlock;

@end
