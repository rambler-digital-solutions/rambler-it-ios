//
//  ModuleAssemblyBase.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol ServiceComponents;
@class PresentationLayerHelpersAssembly;

@interface ModuleAssemblyBase : TyphoonAssembly

@property (strong, nonatomic, readonly) TyphoonAssembly <ServiceComponents> *serviceComponents;
@property (strong, nonatomic, readonly) PresentationLayerHelpersAssembly *presentationLayerHelpersAssembly;

@end
