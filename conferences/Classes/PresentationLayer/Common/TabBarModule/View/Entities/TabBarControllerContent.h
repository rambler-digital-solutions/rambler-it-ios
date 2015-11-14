
#import <Foundation/Foundation.h>
#import "TabBarControllerEmbeddedContentConfigurator.h"

@protocol TabBarControllerContent <NSObject>

@optional
- (UIViewController*)viewController;
- (id<TabBarControllerEmbeddedContentConfigurator>)moduleConfigurator;
- (UIBarButtonItem*)leftBarItem;
- (UIView*)titleView;
- (UIBarButtonItem*)rightBarItem;

@end
