//
//  PredicateConfigurator.h
//  Conferences
//
//  Created by s.sarkisyan on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PredicateConfigurator <NSObject>

- (NSArray<NSPredicate *> *)configureEventsPredicatesForSearchText:(NSString *)searchText;
- (NSArray<NSPredicate *> *)configureSpeakersPredicatesForSearchText:(NSString *)searchText;
- (NSArray<NSPredicate *> *)configureLecturesPredicatesForSearchText:(NSString *)searchText;

@end
