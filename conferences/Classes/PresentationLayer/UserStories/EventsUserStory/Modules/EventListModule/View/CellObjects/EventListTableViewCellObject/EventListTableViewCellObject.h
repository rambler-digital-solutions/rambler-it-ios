//
//  EventListTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@class PlainEvent;

@interface EventListTableViewCellObject : NSObject <NICellObject>

@property (strong, nonatomic, readonly) NSString *day;
@property (strong, nonatomic, readonly) NSString *month;
@property (strong, nonatomic, readonly) NSString *eventTitle;
@property (strong, nonatomic, readonly) NSString *eventTags;

+ (instancetype)objectWithEvent:(PlainEvent *)event eventDay:(NSString *)day eventMonth:(NSString *)month;

@end
