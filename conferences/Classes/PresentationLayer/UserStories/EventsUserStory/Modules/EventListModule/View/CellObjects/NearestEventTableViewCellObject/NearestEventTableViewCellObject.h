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

@interface NearestEventTableViewCellObject : NSObject <NICellObject>

@property (strong, nonatomic, readonly) UIImage *image;
@property (strong, nonatomic, readonly) NSString *day;
@property (strong, nonatomic, readonly) NSString *month;
@property (strong, nonatomic, readonly) NSString *eventTitle;
@property (strong, nonatomic, readonly) UIColor *backgroundColor;
@property (strong, nonatomic, readonly) NSURL *imageUrl;

+ (instancetype)objectWithEvent:(PlainEvent *)event eventDay:(NSString *)day eventMonth:(NSString *)month;

@end
