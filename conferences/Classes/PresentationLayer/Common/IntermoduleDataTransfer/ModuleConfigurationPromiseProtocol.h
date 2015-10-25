
#import <Foundation/Foundation.h>

@protocol ModuleConfiguratorProtocol;
typedef void (^RCCModuleConfigurationBlock)(id<ModuleConfiguratorProtocol> rccModuleConfigurator);

@protocol ModuleConfigurationPromiseProtocol <NSObject>

- (void)thenConfigureModuleWithBlock:(RCCModuleConfigurationBlock)configuraionBlock;

@end
