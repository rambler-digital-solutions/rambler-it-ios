//
//  ApplicationAssembly.h
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "TyphoonAssembly.h"

@protocol ServiceComponents;

/**
 @author Artem Karpushin
 
 This Assembly is responsible for configuration of the objects in charge of the general logic of the application. Such as: applicationConfigurator, appDelegate
 */
@interface ApplicationAssembly : TyphoonAssembly

@property (strong, nonatomic, readonly) TyphoonAssembly<ServiceComponents>* serviceComponents;

@end
