//
//  StubTestHelper.h
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Artem Karpushin
 
 Class is used to perform stubs for particular cases
 */
@interface StubTestHelper : NSObject

/**
 @author Artem Karpushin
 
 Method is used to perform stub of transition handler call
 */
- (void)stubTransitionHandler:(id)transitionHandlerMock withModuleInputMock:(id)moduleInputMock;

@end
