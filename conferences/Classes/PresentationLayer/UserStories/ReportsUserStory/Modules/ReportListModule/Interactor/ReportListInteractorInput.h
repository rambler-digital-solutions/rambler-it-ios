//
//  ReportListInteractorInput.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportListInteractorInput <NSObject>

- (void)updateEventList;
- (NSArray *)obtainEventList;

@end

