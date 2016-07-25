//
//  AnnounceViewModelBuilder.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 25/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DateFormatter;

@interface AnnounceViewModelBuilder : NSObject

@property (nonatomic, strong) DateFormatter *dateFormatter;

- (NSArray *)buildWithEvents:(NSArray *)events;

@end
