//
//  PresentationLayerHelpersAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PresentationLayerHelpersAssembly.h"
#import "EventTypeDeterminator.h"
#import "DateFormatter.h"

@implementation PresentationLayerHelpersAssembly

- (EventTypeDeterminator *)eventTypeDeterminator {
    return [TyphoonDefinition withClass:[EventTypeDeterminator class]];
}

- (DateFormatter *)dateFormatter {
    return [TyphoonDefinition withClass:[DateFormatter class]];
}

@end
