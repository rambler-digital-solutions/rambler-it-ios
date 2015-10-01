//
//  RCFLectureService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class Lecture;

typedef void (^RCFLectureCompletionBlock)(Lecture *lecture, NSError *error);

@protocol RCFLectureService <NSObject>

- (Lecture *)obtainLectureWithPredicate:(NSPredicate *)predicate;

- (void)updateLectureWithPredicate:(NSPredicate *)predicate completionBlock:(RCFLectureCompletionBlock)completionBlock;

@end
