//
//  RDSModuleConfigurationPromise.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 27/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSModuleConfigurationPromise.h"

@interface RDSModuleConfigurationPromise ()

@property (nonatomic,strong) RCCModuleConfigurationBlock configuraionBlock;

@end

@implementation RDSModuleConfigurationPromise

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
