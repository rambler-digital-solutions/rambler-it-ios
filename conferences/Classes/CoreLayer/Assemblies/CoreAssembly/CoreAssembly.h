//
//  CoreAssembly.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 20/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ModuleAssemblyBase.h"

@protocol ROSPonsomizer;

/**
 @author Vasyura Anastasiya
 
 Assembly with core components
 */
@interface CoreAssembly : ModuleAssemblyBase

- (id <ROSPonsomizer>)ponsomizer;

@end
