//
//  ReportSearchAssembly.h
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleAssemblyBase.h"
#import "PonsomizerAssembly.h"

@protocol RamblerInitialAssembly;

@interface ReportsSearchAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@property (nonatomic, strong) PonsomizerAssembly *ponsomizerAssembly;

@end
