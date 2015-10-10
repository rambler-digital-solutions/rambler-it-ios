//
//  SpeakerService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class Speaker;

typedef void (^SpeakerCompletionBlock)(Speaker *speaker, NSError *error);

@protocol SpeakerService <NSObject>

- (Speaker *)obtainSpeakerWithPredicate:(NSPredicate *)predicate;

- (void)updateSpeakerWithPredicate:(NSPredicate *)predicate completionBlock:(SpeakerCompletionBlock)completionBlock;

@end
