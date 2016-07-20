//
//  CoreAssembly.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 20/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "CoreAssembly.h"
#import "ROSPonsomizerImplementation.h"

@implementation CoreAssembly

- (id <ROSPonsomizer>)ponsomizer {
    return [TyphoonDefinition withClass:[ROSPonsomizerImplementation class]];
}

@end
