//
//  EventListModuleAssembly.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "ModuleAssemblyBase.h"

@protocol TabBarButtonPrototypeProtocol;
@protocol ServiceComponents;

@interface EventListModuleAssembly : ModuleAssemblyBase

@property (strong, nonatomic, readonly) TyphoonAssembly <ServiceComponents> *serviceComponents;

- (id<TabBarButtonPrototypeProtocol>)eventListTabBarButtonPrototype;

@end

