//
//  EventDataDisplayManager.h
//  Conferences
//
//  Created by Karpushin Artem on 04/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataDisplayManager.h"

@class PlainEvent;

@interface EventDataDisplayManager : NSObject <DataDisplayManager>

- (void)configureDataDisplayManagerWithEvent:(PlainEvent *)event;

@end
