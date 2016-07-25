//
//  UIView+LJLoadFromNib.m
//  LiveJournal
//
//  Created by Smal Vadim on 30/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "UIView+LJLoadFromNib.h"

@implementation UIView (LJLoadFromNib)

+ (instancetype)loadFromNib {
    return [[[NSBundle bundleForClass:self] loadNibNamed:NSStringFromClass([self class])
                                                   owner:self
                                                 options:NULL] firstObject];
}

+ (instancetype)loadFromNibWithName:(NSString *)nibName {
    return [[[NSBundle bundleForClass:self] loadNibNamed:nibName
                                                   owner:self
                                                 options:NULL] firstObject];
}

@end
