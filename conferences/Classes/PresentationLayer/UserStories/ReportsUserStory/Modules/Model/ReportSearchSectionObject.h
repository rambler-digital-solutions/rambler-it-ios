//
//  ReportSearchSectionObject.h
//  Conferences
//
//  Created by k.zinovyev on 17.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportSearchSectionObject : NSObject

@property (nonatomic, strong) NSString *titleSection;
@property (nonatomic, strong) NSString *nameObjectClassInSection;
@property (nonatomic, strong) UIColor *backgroundColorSection;

+(instancetype)objectSectionWithTitle:(NSString *)title
                        nameObjectClass:(NSString *)nameClass
                      backgroundColor:(UIColor *)color;

@end
