//
//  RamblerViperPlaceholderViewController.h
//  Pods
//
//  Created by Andrey Zarembo-Godzyatsky on 25/09/15.
//
//

#import <UIKit/UIKit.h>

/**
 Placeholder view controller used like Storyboard References, but for iOS 7.
 
 Place it onto Storyboard and set Restoration ID to format:
 "RestorationIdOfDestinationViewController@DestinationViewControllerStoryboardName"
 
 Then use usual segue to it. 
 */
@interface RamblerPlaceholderViewController : UIViewController

// Method used to obtain instantiated destination view controller
- (id)destinationViewControllerForSegue;

@end
