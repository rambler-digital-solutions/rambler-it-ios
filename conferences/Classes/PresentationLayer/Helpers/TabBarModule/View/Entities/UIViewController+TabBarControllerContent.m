
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
