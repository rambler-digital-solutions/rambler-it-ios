//
//  ReportSearchSectionTitleCellObject.m
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportSearchSectionTitleCellObject.h"
#import "ReportSearchSectionTitleTableViewCell.h"

@interface ReportSearchSectionTitleCellObject ()

@property (strong, nonatomic, readwrite) NSString *sectionTitle;
@property (strong, nonatomic, readwrite) UIColor *backgroundColorSection;

@end

@implementation ReportSearchSectionTitleCellObject

- (instancetype)initWithSectonTitle:(NSString *)sectionTitle
                    backgroundColor:(UIColor *)color {
    self = [super init];
    if (self) {
        _sectionTitle = sectionTitle;
        _backgroundColorSection = color;
    }
    return self;
}

+ (instancetype)objectWithSectionTitle:(NSString *)title
                       backgroundColor:(UIColor *)color {
    
    return [[self alloc] initWithSectonTitle:title
                             backgroundColor:color];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [ReportSearchSectionTitleTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([ReportSearchSectionTitleTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
