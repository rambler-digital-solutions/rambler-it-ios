//
//  ReportSearchSectionTitleCellObject.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ReportSearchSectionTitleCellObject : NSObject

@property (nonatomic, strong, readonly) NSString *sectionTitle;
@property (nonatomic, strong, readonly) UIColor *backgroundColorSection;

+ (instancetype)objectWithSectionTitle:(NSString *)title
                       backgroundColor:(UIColor *)color;

@end
