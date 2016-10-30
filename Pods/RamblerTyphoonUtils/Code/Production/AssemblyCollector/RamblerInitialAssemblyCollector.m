//
//  RamblerInitialAssemblyCollector.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RamblerInitialAssemblyCollector.h"
#import "RamblerInitialAssembly.h"
#import <objc/runtime.h>

@implementation RamblerInitialAssemblyCollector

- (NSArray *)collectInitialAssemblyClasses {
    NSMutableSet *resultClasses = [NSMutableSet set];
    
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class nextClass = classes[i];
            if ([self checkIfClassIsInitialAssembly:nextClass]) {
                [resultClasses addObject:nextClass];
            }
        }
        free(classes);
    }
    return [resultClasses allObjects];
}

- (NSArray *)collectInitialAssembliesExceptOne:(id)excludedAssembly {
    NSArray<Class> *initialAssemblyClasses = [self collectInitialAssemblyClasses];
    NSMutableArray *initialAssemblies = [@[] mutableCopy];
    
    for (Class assemblyClass in initialAssemblyClasses) {
        if (assemblyClass != [excludedAssembly class]) {
            [initialAssemblies addObject:[assemblyClass new]];
        }
    }
    return [initialAssemblies copy];
}

- (BOOL)checkIfClassIsInitialAssembly:(Class)assemblyClass {
    if (assemblyClass == nil) {
        return NO;
    }
    
    if (class_conformsToProtocol(assemblyClass, @protocol(RamblerInitialAssembly))) {
        return YES;
    } else {
        return [self checkIfClassIsInitialAssembly:class_getSuperclass(assemblyClass)];
    }
}

@end
