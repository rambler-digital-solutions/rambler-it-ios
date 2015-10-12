//
//  RamblerLocationPresenter.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RamblerLocationViewOutput.h"
#import "RamblerLocationInteractorOutput.h"

@protocol RamblerLocationViewInput;
@protocol RamblerLocationInteractorInput;
@protocol RamblerLocationRouterInput;

@interface RamblerLocationPresenter : NSObject<RamblerLocationViewOutput,RamblerLocationInteractorOutput>

@property (nonatomic, weak) id<RamblerLocationViewInput> view;
@property (nonatomic, strong) id<RamblerLocationInteractorInput>  interactor;
@property (nonatomic, strong) id<RamblerLocationRouterInput> router;

@end

