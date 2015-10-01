//
//  RCFLectureMaterialsService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class LectureMaterials;

typedef void (^RCFLectureMaterialsCompletionBlock)(LectureMaterials *lectureMaterials, NSError *error);

@protocol RCFLectureMaterialsService <NSObject>

- (LectureMaterials *)obtainLectureMaterialsWithPredicate:(NSPredicate *)predicate;

- (void)updateLectureMaterialsWithPredicate:(NSPredicate *)predicate completionBlock:(RCFLectureMaterialsCompletionBlock)completionBlock;

@end
