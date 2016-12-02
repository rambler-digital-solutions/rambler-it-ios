//
//  SearchFacade.h
//  Conferences
//
//  Created by s.sarkisyan on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchFacade <NSObject>

- (NSArray *)eventsForPredicates:(NSArray<NSPredicate *> *)predicates;
- (NSArray *)speakersForPredicates:(NSArray<NSPredicate *> *)predicates;
- (NSArray *)lecturesForPredicates:(NSArray<NSPredicate *> *)predicates;

@end
