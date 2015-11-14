//
//  EventListInteractorInput.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EventListInteractorInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to update list of events
 */
- (void)updateEventList;

/**
 @author Artem Karpushin
 
 Method is used to obtain list of events
 
 @return Array of PlainEvent objects
 */
- (NSArray *)obtainEventList;

@end

