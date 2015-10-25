
#import "ModuleConfigurationPromise.h"

@interface ModuleConfigurationPromise ()

@property (nonatomic,strong) RCCModuleConfigurationBlock configuraionBlock;

@end

@implementation ModuleConfigurationPromise

- (void)thenConfigureModuleWithBlock:(RCCModuleConfigurationBlock)configuraionBlock {
    self.configuraionBlock = configuraionBlock;
    [self tryToExecute];
}

- (void)setModuleConfigurator:(id<RDSModuleConfiguratorProtocol>)moduleConfigurator {
    _moduleConfigurator = moduleConfigurator;
    [self tryToExecute];
}

-(void)tryToExecute {
    if (self.moduleConfigurator != nil && self.configuraionBlock != nil) {
        self.configuraionBlock(self.moduleConfigurator);
        [self didExecute];
    }
}

- (void)didExecute {
    
}

@end
