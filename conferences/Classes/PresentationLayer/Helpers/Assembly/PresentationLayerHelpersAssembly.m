//
//  PresentationLayerHelpersAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PresentationLayerHelpersAssembly.h"
#import "EventTypeSetter.h"

@implementation PresentationLayerHelpersAssembly

- (EventTypeSetter *)eventTypeSetter {
    return [TyphoonDefinition withClass:[EventTypeSetter class]];
}

@end
