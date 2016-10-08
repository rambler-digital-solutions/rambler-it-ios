//
//  MessageExtensionAssembly.h
//  Conferences
//
//  Created by Trishina Ekaterina on 18/09/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ModuleAssemblyBase.h"
#import "AssemblyCollector/RamblerInitialAssembly.h"

@class EventListModuleAssembly;

@interface MessageExtensionAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@property (strong, nonatomic) EventListModuleAssembly *eventListAssembly;

@end
