//
//  EventHeaderInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventHeaderInteractorInput.h"

@protocol EventHeaderInteractorOutput;

@interface EventHeaderInteractor : NSObject<EventHeaderInteractorInput>

@property (nonatomic, weak) id<EventHeaderInteractorOutput> output;

@end

