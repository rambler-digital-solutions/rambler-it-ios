//
//  EventListModuleAssembly.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "ModuleAssemblyBase.h"

@protocol TabBarButtonPrototypeProtocol;

@interface EventListModuleAssembly : ModuleAssemblyBase

- (id<TabBarButtonPrototypeProtocol>)eventListTabBarButtonPrototype;

@end

