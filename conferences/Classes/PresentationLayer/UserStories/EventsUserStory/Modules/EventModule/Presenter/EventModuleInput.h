//
//  EventModuleInput.h
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@class PlainEvent;

@protocol EventModuleInput <RamblerViperModuleInput>

- (void)configureCurrentModuleWithEventObjectId:(NSString *)objectId;

@end