//
//  TVLectureListModuleTVLectureListModuleRouter.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVLectureListModuleRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface TVLectureListModuleRouter : NSObject <TVLectureListModuleRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
