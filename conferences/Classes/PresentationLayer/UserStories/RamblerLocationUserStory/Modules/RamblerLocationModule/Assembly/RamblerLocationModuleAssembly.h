//
//  RamblerLocationModuleAssembly.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "ModuleAssemblyBase.h"

@protocol TabBarButtonPrototypeProtocol;

@interface RamblerLocationModuleAssembly : ModuleAssemblyBase

- (id<TabBarButtonPrototypeProtocol>)ramblerLocationTabBarButtonPrototype;

@end

