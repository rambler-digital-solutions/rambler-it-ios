//
//  RDSModuleConfiguratorHolder.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 30/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RDSModuleConfiguratorProtocol;

@protocol RDSModuleConfiguratorHolder <NSObject>

- (id<RDSModuleConfiguratorProtocol>)moduleConfigurator;

@end
