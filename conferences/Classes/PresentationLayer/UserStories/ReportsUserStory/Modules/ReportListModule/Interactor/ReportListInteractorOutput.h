//
//  ReportListInteractorOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportListInteractorOutput <NSObject>

- (void)didUpdateEventList:(NSArray *)events;

@end

