//
//  ReportsSearchRouter.h
//  Conferences
//
//  Created by k.zinovyev on 19.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>
#import "ReportsSearchRouterInput.h"

@interface ReportsSearchRouter : NSObject<ReportsSearchRouterInput>

@property (weak, nonatomic) id <RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end