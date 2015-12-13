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

#import "EmbedModuleSegue.h"

@implementation EmbedModuleSegue


- (void)perform {
    
    UIViewController *parentViewController = self.sourceViewController;
    UIViewController *embeddableModuleViewController = self.destinationViewController;

    for (UIView *childView in [self.containerView.subviews copy]) {
        for (UIViewController* childViewController in [parentViewController.childViewControllers copy]) {
            if (childViewController.view == childView) {
                [childView removeFromSuperview];
                [childViewController removeFromParentViewController];
            }
        }
    }
    
    
    [parentViewController addChildViewController:embeddableModuleViewController];
    
    UIView *moduleView = embeddableModuleViewController.view;
    moduleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview: moduleView];
    
    

    // align moduleView from the left and right
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[moduleView]-0-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(moduleView)]];
    
    // align moduleView from the top and bottom
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[moduleView]-0-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(moduleView)]];
}

@end
