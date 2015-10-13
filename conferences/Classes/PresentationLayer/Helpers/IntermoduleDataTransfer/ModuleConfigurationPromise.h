
#import <UIKit/UIKit.h>
#import "ModuleConfigurationPromiseProtocol.h"

@protocol RDSModuleConfiguratorProtocol;

@interface ModuleConfigurationPromise : NSObject<ModuleConfigurationPromiseProtocol>

@property(nonatomic,strong) id<RDSModuleConfiguratorProtocol> moduleConfigurator;

- (void)didExecute;

@end
