//
//  RDSModuleTransitionSegueInfo.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 21/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RDSModuleConfigurationPromiseProtocol;

@interface RDSModuleTransitionSegueInfo : NSObject

@property (nonatomic,strong,readonly) id sender;
@property (nonatomic,strong,readonly) id<RDSModuleConfigurationPromiseProtocol> promise;

- (instancetype)initWithSender:(id)sender andPromise:(id<RDSModuleConfigurationPromiseProtocol>)promise;

@end
