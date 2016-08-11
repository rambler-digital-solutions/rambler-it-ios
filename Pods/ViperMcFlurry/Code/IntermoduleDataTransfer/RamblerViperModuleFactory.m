
//
//  RamblerViperModuleFactory.m
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RamblerViperModuleFactory.h"

@interface RamblerViperModuleFactory ()

@property (nonatomic,strong) UIStoryboard *storyboard;
@property (nonatomic,strong) NSString* restorationId;
@property (nonatomic,copy) id<RamblerViperModuleTransitionHandlerProtocol>(^viewHandler)(void);

@end

@implementation RamblerViperModuleFactory

- (instancetype)initWithStoryboard:(UIStoryboard*)storyboard andRestorationId:(NSString*)restorationId {
    self = [super init];
    if (self) {
        self.storyboard = storyboard;
        self.restorationId = restorationId;
    }
    return self;
}

- (instancetype)initWithViewHandler:(id<RamblerViperModuleTransitionHandlerProtocol>(^)(void))viewHandler {
    self = [super init];
    if (self) {
        self.viewHandler = viewHandler;
    }
    return self;
}

#pragma mark - RDSModuleFactoryProtocol

- (__nullable id<RamblerViperModuleTransitionHandlerProtocol>)instantiateModuleTransitionHandler {
    if (self.viewHandler) {
        return self.viewHandler();
    }
    
    id<RamblerViperModuleTransitionHandlerProtocol> destinationViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.restorationId];
    return destinationViewController;
}

@end
