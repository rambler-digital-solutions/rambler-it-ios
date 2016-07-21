//
//  RamblerPlaceholderViewController.m
//  Pods
//
//  Created by Andrey Zarembo-Godzyatsky on 25/09/15.
//
//

#import "RamblerPlaceholderViewController.h"

@interface RamblerPlaceholderViewController ()

@end

@implementation RamblerPlaceholderViewController

- (id)destinationViewControllerForSegue {
    
    NSArray *parts = [self.restorationIdentifier componentsSeparatedByString:@"@"];
    if (parts.count != 2) {
        return nil;
    }
    
    NSString *storyboardName = parts.lastObject;
    NSString *viewControllerId = parts.firstObject;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName
                                                         bundle:nil];
    id destinationViewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    return destinationViewController;
}

@end
