//
//  FutureEventTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@class PlainEvent;

@interface FutureEventTableViewCellObject : NIFormElement <NICellObject>

@property (strong, nonatomic, readonly) UIImage *image;
@property (strong, nonatomic, readonly) NSString *day;
@property (strong, nonatomic, readonly) NSString *month;
@property (strong, nonatomic, readonly) NSString *eventTitle;
@property (strong, nonatomic, readonly) UIColor *backgroundColor;

+ (instancetype)objectWithElementID:(NSInteger)elementID event:(PlainEvent *)event;

@end
