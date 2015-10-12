//
//  RDSModuleConfigurationPromiseProtocol.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 27/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RDSModuleConfiguratorProtocol;
typedef void (^RCCModuleConfigurationBlock)(id<RDSModuleConfiguratorProtocol> rccModuleConfigurator);

@protocol RDSModuleConfigurationPromiseProtocol <NSObject>

- (void)thenConfigureModuleWithBlock:(RCCModuleConfigurationBlock)configuraionBlock;

@end
