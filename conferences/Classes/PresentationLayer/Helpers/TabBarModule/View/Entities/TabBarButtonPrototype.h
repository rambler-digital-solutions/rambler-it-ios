
#import <UIKit/UIKit.h>
#import "TabBarButtonPrototypeProtocol.h"

@interface TabBarButtonPrototype : NSObject<TabBarButtonPrototypeProtocol>

@property (nonatomic,strong) UIImage  *tabBarButtonIdleStateImage;
@property (nonatomic,strong) UIImage  *tabBarButtonSelectedStateImage;
@property (nonatomic,strong) NSString *tabBarButtonTitle;
@property (nonatomic,strong) NSString *tabbarButtonId;
@property (nonatomic,strong) id<TabBarControllerContent> tabBarControllercontent;

@end
