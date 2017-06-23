//
//  RamblerViperModuleTransitionHandlerProtocol.h
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RamblerViperOpenModulePromise;
@protocol RamblerViperModuleInput;
@class RamblerViperModuleFactory;
@protocol RamblerViperModuleTransitionHandlerProtocol;
@protocol RamblerViperModuleFactoryProtocol;

typedef void (^ModuleTransitionBlock)(id<RamblerViperModuleTransitionHandlerProtocol> sourceModuleTransitionHandler,
                                      id<RamblerViperModuleTransitionHandlerProtocol> destinationModuleTransitionHandler);

/**
 Protocol defines interface for intermodule transition
 */
@protocol RamblerViperModuleTransitionHandlerProtocol <NSObject>

@optional

// Module input object
@property (nonatomic, strong) id<RamblerViperModuleInput> moduleInput;

// Performs segue without any actions, useful for unwind segues
- (void)performSegue:(NSString *)segueIdentifier;
// Method opens module using segue
- (RamblerViperOpenModulePromise*)openModuleUsingSegue:(NSString*)segueIdentifier;
// Method opens module using module factory
- (RamblerViperOpenModulePromise*)openModuleUsingFactory:(id <RamblerViperModuleFactoryProtocol>)moduleFactory withTransitionBlock:(ModuleTransitionBlock)transitionBlock;
// Method removes/closes module
- (void)closeCurrentModule:(BOOL)animated;

@end
