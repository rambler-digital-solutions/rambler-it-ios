//
//  TVEventListModuleTVEventListModuleRouter.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVEventListModuleRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface TVEventListModuleRouter : NSObject <TVEventListModuleRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
