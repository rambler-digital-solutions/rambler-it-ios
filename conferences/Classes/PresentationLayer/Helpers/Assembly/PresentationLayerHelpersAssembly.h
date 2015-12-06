//
//  PresentationLayerHelpersAssembly.h
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@class EventTypeDeterminator;
@class DateFormatter;

/**
 @author Artem Karpushin
 
 A TyphoonAssembly which is responsible for creating helper objects for presentation layer
 */
@interface PresentationLayerHelpersAssembly : TyphoonAssembly

- (EventTypeDeterminator *)eventTypeDeterminator;
- (DateFormatter *)dateFormatter;

@end
