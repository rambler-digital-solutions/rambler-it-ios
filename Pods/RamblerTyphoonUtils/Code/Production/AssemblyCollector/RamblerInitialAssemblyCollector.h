//
//  RamblerInitialAssemblyCollector.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class traverses all of the application classes in the runtime and detects InitialAssemblies.
 */
@interface RamblerInitialAssemblyCollector : NSObject

/**
This method returns an array of TyphoonAssemly classes which requires activation on startup.

@return NSArray of TyphoonAssembly classes
*/
- (NSArray *)collectInitialAssemblyClasses;

/**
 This method returns an array of TyphoonAssemlies which requires activation on startup, except assembly in parameter.
 
 @parameter excludedAssembly TyphoonAssemly which instance is not needed
 
 @return NSArray of TyphoonAssembly objects
 */
- (NSArray *)collectInitialAssembliesExceptOne:(id)excludedAssembly;

@end
