
#import <Foundation/Foundation.h>

@protocol RDSModuleConfiguratorProtocol;

@protocol ModuleConfiguratorHolder <NSObject>

- (id<RDSModuleConfiguratorProtocol>)moduleConfigurator;

@end
