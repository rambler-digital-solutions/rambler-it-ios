//
//  CoreAssembly.h
//  Conferences
//
//  Created by Vasyura Anastasiya on 20/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol ROSPonsomizer;

@interface CoreAssembly : TyphoonAssembly

- (id <ROSPonsomizer>)ponsomizer;

@end
