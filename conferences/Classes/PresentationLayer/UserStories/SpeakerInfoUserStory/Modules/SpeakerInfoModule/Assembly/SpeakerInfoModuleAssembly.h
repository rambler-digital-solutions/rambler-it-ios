//
//  SpeakerInfoModuleAssembly.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import "ModuleAssemblyBase.h"
#import "AssemblyCollector/RamblerInitialAssembly.h"

/**
 @author Artem Karpushin
 
 A TyphoonAssembly which is responsible for creating SpeakerInfoModule
 */
@interface SpeakerInfoModuleAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@end

