
#import <Foundation/Foundation.h>
#import "ModuleConfiguratorProtocol.h"

@protocol TabBarControllerEmbeddedContentConfigurator <ModuleConfiguratorProtocol>

- (void)configureWithTagBarButtonId:(NSString*)tabBarButtonId;

@end
