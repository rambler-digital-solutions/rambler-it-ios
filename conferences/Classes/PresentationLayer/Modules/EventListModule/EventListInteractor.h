//
//  EventListInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListInteractorInput.h"

@protocol EventListInteractorOutput;

/**
 *  Interactor модуля, который 1
 *	
 */
@interface EventListInteractor : NSObject<EventListInteractorInput>

@property (nonatomic, weak) id<EventListInteractorOutput> output;

@end

