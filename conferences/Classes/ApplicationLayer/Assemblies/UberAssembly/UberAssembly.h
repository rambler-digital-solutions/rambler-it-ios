//
//  UberAssembly.h
//  Conferences
//
//  Created by a.yakimenko on 18.10.2017.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import <RamblerTyphoonUtils/AssemblyCollector.h>

@class UberRidesAppDelegate;

@interface UberAssembly : TyphoonAssembly <RamblerInitialAssembly>

- (UberRidesAppDelegate *)uberRidesAppDelegate;

@end
