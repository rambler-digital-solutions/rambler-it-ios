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
@class EventCellObjectBuilderFactory;

@interface EventDataDisplayManager : NSObject <DataDisplayManager>

@property (strong, nonatomic) EventCellObjectBuilderFactory *cellObjectBuilderFactory;

- (void)configureDataDisplayManagerWithEvent:(PlainEvent *)event;

@end
