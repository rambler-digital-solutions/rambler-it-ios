
#import <UIKit/UIKit.h>
#import "ModuleConfigurationPromiseProtocol.h"

@protocol TabBarControllerContent;

@protocol TabBarButtonPrototypeProtocol <NSObject>

- (UIImage*)tabBarButtonIdleStateImage;
- (UIImage*)tabBarButtonSelectedStateImage;
- (NSString*)tabBarButtonTitle;
- (NSString*)tabbarButtonId;
- (id<TabBarControllerContent>)tabBarControllercontent;

@end
