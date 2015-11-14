//
//  EventInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventInteractorInput.h"

@protocol EventInteractorOutput;

@interface EventInteractor : NSObject<EventInteractorInput>

@property (nonatomic, weak) id<EventInteractorOutput> output;

@end

