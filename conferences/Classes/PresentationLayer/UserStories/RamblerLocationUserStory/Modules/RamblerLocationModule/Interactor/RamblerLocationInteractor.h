//
//  RamblerLocationInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RamblerLocationInteractorInput.h"

@protocol RamblerLocationInteractorOutput;

/**
 *  Interactor модуля, который 1
 *	
 */
@interface RamblerLocationInteractor : NSObject<RamblerLocationInteractorInput>

@property (nonatomic, weak) id<RamblerLocationInteractorOutput> output;

@end

