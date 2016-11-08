//
//  MessageExtensionAssembly.h
//  Conferences
//
//  Created by Trishina Ekaterina on 18/09/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ModuleAssemblyBase.h"
#import <RamblerTyphoonUtils/AssemblyCollector.h>

@class EventListModuleAssembly, PonsomizerAssembly, SpotlightIndexerAssembly;

@interface MessageExtensionAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@property (strong, nonatomic) EventListModuleAssembly *eventListAssembly;
@property (nonatomic, strong) PonsomizerAssembly *ponsomizerAssembly;
@property (strong, nonatomic, readonly) SpotlightIndexerAssembly *spotlightIndexerAssembly;

@end
