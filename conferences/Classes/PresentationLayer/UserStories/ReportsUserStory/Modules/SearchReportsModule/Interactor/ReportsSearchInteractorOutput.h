//
//  ReportsSearchInteractorOutput.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReportsSearchInteractorOutput <NSObject>

- (void)didUpdateEventList:(NSArray *)events;

@end

