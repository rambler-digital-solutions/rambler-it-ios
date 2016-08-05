//
//  TagAssembly.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import <RamblerTyphoonUtils/AssemblyCollector.h>
#import "ModuleAssemblyBase.h"

@protocol ServicesAssembly;

/**
 @author Golovko Mikhail

 Модуль отображения тегов.
 */
@interface TagAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@end