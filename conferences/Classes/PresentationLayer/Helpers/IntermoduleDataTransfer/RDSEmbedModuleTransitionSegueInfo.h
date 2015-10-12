//
//  RDSEmbedModuleTransitionSegueInfo.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 21/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSModuleTransitionSegueInfo.h"

@interface RDSEmbedModuleTransitionSegueInfo : RDSModuleTransitionSegueInfo

@property (nonatomic,strong,readonly) UIView *containerView;

- (instancetype)initWithSender:(id)sender andPromise:(id<RDSModuleConfigurationPromiseProtocol>)promise andContainerView:(UIView*)containerView;

@end
