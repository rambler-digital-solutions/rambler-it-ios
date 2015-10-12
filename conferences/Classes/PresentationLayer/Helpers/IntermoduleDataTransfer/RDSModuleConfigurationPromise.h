//
//  RDSModuleConfigurationPromise.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 27/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDSModuleConfigurationPromiseProtocol.h"

@protocol RDSModuleConfiguratorProtocol;

@interface RDSModuleConfigurationPromise : NSObject<RDSModuleConfigurationPromiseProtocol>

@property(nonatomic,strong) id<RDSModuleConfiguratorProtocol> moduleConfigurator;

- (void)didExecute;

@end
