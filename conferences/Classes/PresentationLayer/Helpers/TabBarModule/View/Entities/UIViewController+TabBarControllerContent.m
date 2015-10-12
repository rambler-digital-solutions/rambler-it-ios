//
//  UIViewController+TabBarControllerContent.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 11/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "UIViewController+TabBarControllerContent.h"

@implementation UIViewController (TabBarControllerContent)

- (UIViewController*)viewController {
    return self;
}

- (UIBarButtonItem *)leftBarItem {
    return self.navigationItem.leftBarButtonItem;
}

- (UIBarButtonItem *)rightBarItem {
    return self.navigationItem.rightBarButtonItem;
}

@end
