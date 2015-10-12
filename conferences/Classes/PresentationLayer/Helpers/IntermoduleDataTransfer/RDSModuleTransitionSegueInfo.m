//
//  RDSModuleTransitionSegueInfo.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 21/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSModuleTransitionSegueInfo.h"

@interface RDSModuleTransitionSegueInfo()

@property (nonatomic,strong) id sender;
@property (nonatomic,strong) id<RDSModuleConfigurationPromiseProtocol> promise;

@end

@implementation RDSModuleTransitionSegueInfo

- (instancetype)initWithSender:(id)sender andPromise:(id<RDSModuleConfigurationPromiseProtocol>)promise {
    self = [super init];
    if (self) {
        self.sender = sender;
        self.promise = promise;
    }
    return self;
}

@end
