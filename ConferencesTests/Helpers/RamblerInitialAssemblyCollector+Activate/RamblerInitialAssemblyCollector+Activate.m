//
//  RamblerTyphoonAssemblyTests+Activate.m
//  LiveJournal
//
//  Created by Smal Vadim on 22/04/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "RamblerInitialAssemblyCollector+Activate.h"
#import <Typhoon/Typhoon.h>
#import <RamblerTyphoonUtils/AssemblyCollector.h>

@implementation RamblerInitialAssemblyCollector (Activate)

+ (id)rds_activateAssemblyWithClass:(Class)class {
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    NSArray *assemblyClasses = [collector collectInitialAssemblyClasses];
    NSMutableArray *collaboratingAssemblies = [NSMutableArray array];
    for (Class assemblyClass in assemblyClasses) {
        if (assemblyClass == class) {
            continue;
        }
        TyphoonAssembly *assembly = [assemblyClass new];
        [collaboratingAssemblies addObject:assembly];
    }
    
    TyphoonAssembly *assembly = [[class alloc] init];
    [assembly activateWithCollaboratingAssemblies:collaboratingAssemblies];
    [TyphoonComponentFactory setFactoryForResolvingUI:(TyphoonComponentFactory *)assembly];
    return assembly;
}

@end
