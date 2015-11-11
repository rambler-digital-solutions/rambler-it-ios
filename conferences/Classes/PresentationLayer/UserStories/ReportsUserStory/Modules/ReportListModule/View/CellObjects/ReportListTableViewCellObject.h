//
//  ReportListTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

@class PlainEvent;

@interface ReportListTableViewCellObject : NIFormElement <NICellObject>

@property (strong, nonatomic, readonly) NSString *date;
@property (strong, nonatomic, readonly) NSString *eventTitle;
@property (strong, nonatomic, readonly) UIImage *eventImage;

+ (instancetype)objectWithElementID:(NSInteger)elementID event:(PlainEvent *)event;

@end
