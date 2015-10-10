//
//  LectureMaterialsService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class LectureMaterials;

typedef void (^LectureMaterialsCompletionBlock)(LectureMaterials *lectureMaterials, NSError *error);

@protocol LectureMaterialsService <NSObject>

- (LectureMaterials *)obtainLectureMaterialsWithPredicate:(NSPredicate *)predicate;

- (void)updateLectureMaterialsWithPredicate:(NSPredicate *)predicate completionBlock:(LectureMaterialsCompletionBlock)completionBlock;

@end
