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

/**
 @author Artem Karpushin
 
 The service is designed to obtain / update LectureMaterials objects
 */
@protocol LectureMaterialsService <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain LectureMaterials object from cache
 
 @param predicate NSPredicate for specifying the filtering parameters
 
 @return LectureMaterials object
 */
- (LectureMaterials *)obtainLectureMaterialsWithPredicate:(NSPredicate *)predicate;

/**
 @author Artem Karpushin
 
 Method is used to update LectureMaterials object by sending request to server
 
 @param predicate NSPredicate for specifying the filtering parameters
 @param completionBlock LectureMaterialsCompletionBlock called upon completion the method, and returns LectureMaterials object and NSError object if there is any
 */
- (void)updateLectureMaterialsWithPredicate:(NSPredicate *)predicate completionBlock:(LectureMaterialsCompletionBlock)completionBlock;

@end
