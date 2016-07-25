//
//  ReportsSearchCellObjectsBuilder.h
//  Conferences
//
//  Created by k.zinovyev on 25.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DateFormatter;
@protocol ReportsSearchCellObjectsBuilder;

@interface ReportsSearchCellObjectsBuilderImplementation <ReportsSearchCellObjectsBuilder> : NSObject

@property (strong, nonatomic) DateFormatter *dateFormatter;

- (instancetype)initWithDateFormatter:(DateFormatter *)dateFormatter;

@end
