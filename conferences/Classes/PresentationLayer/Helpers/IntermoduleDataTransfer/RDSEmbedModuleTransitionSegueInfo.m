//
//  RDSEmbedModuleTransitionSegueInfo.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 21/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSEmbedModuleTransitionSegueInfo.h"

@interface RDSEmbedModuleTransitionSegueInfo()

@property (nonatomic,strong) UIView *containerView;

@end

@implementation RDSEmbedModuleTransitionSegueInfo

- (instancetype)initWithSender:(id)sender andPromise:(id<RDSModuleConfigurationPromiseProtocol>)promise andContainerView:(UIView*)containerView {
    self = [super initWithSender:sender andPromise:promise];
    if (self) {
        self.containerView = containerView;
    }
    return self;
}

@end
