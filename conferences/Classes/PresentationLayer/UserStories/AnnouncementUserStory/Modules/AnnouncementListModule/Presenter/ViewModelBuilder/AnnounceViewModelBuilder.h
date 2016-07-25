//
//  AnnounceViewModelBuilder.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 25/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DateFormatter;

/**
 @author Vasyura Anastasiya
 
 Builder for announce view models
 */
@interface AnnounceViewModelBuilder : NSObject

@property (nonatomic, strong) DateFormatter *dateFormatter;

- (NSArray *)buildWithEvents:(NSArray *)events;

@end
