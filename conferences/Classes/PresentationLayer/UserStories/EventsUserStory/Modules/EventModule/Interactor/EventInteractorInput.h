//
//  EventInteractorInput.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventInteractorInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to inform interactor that need to obtain event with specified object id
 
 @param objectId Event object id
 */
- (void)obtainEventByObjectId:(NSString *)objectId;

@end

