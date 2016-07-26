//
//  UINavigationBar+States.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 26/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "UINavigationBar+States.h"

@implementation UINavigationBar (States)

- (void)becomeTransparent {
    UIImage *clearImage = [UIImage new];
    [self setBackgroundImage:clearImage
               forBarMetrics:UIBarMetricsDefault];
    [self setTranslucent:YES];
    [self setShadowImage:clearImage];
}

@end
