// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "TabBarControllerFactoryImplementation.h"

#import <UIKit/UIKit.h>

@interface TabBarControllerFactoryImplementation ()

@property (nonatomic, strong) UIStoryboard *storyboard;

@end

@implementation TabBarControllerFactoryImplementation

#pragma mark - Initialization

- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard {
    self = [super init];
    if (self) {
        _storyboard = storyboard;
    }
    return self;
}

+ (instancetype)factoryWithStoryboard:(UIStoryboard *)storyboard {
    return [[self alloc] initWithStoryboard:storyboard];
}

#pragma mark - <TabBarControllerFactory>

- (UITabBarController *)obtainPreconfiguredTabBarController {
    UITabBarController *tabBarController = [self.storyboard instantiateInitialViewController];
    return tabBarController;
}

@end
