//
//  ReportSearchSectionObject.m
//  Conferences
//
//  Created by k.zinovyev on 17.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportSearchSectionObject.h"

@implementation ReportSearchSectionObject

-(instancetype)initWithTitle:(NSString *)title
               nameObjectClass:(NSString *)nameClass
             backgroundColor:(UIColor *)color {
    self = [super init];
    if (self) {
        _titleSection = title;
        _nameObjectClassInSection = nameClass;
        _backgroundColorSection = color;
    }
    return self;
    
}

+(instancetype)objectSectionWithTitle:(NSString *)title
                        nameObjectClass:(NSString *)nameClass
                      backgroundColor:(UIColor *)color {
        return [[self alloc] initWithTitle:title
                             nameObjectClass:nameClass
                           backgroundColor:color];
}

@end
