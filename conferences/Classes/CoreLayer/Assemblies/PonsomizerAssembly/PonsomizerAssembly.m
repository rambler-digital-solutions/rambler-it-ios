//
//  CoreAssembly.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 20/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "PonsomizerAssembly.h"
#import "ROSPonsomizerImplementation.h"

@implementation PonsomizerAssembly

- (id <ROSPonsomizer>)ponsomizer {
    return [TyphoonDefinition withClass:[ROSPonsomizerImplementation class]];
}

@end
