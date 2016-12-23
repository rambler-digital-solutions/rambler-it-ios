//
//  ROCMVerifier.h
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 20/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RamblerVerifySetter(instance, property) \
    [ROCMVerifier rds_checkSetter:instance propertyName:NSStringFromSelector(@selector(property))]

/**
 Verify helper. Checking the object whether it confirmes type of property. 
 Object is setted in a property.
 */
@interface ROCMVerifier : NSObject

+ (void)rds_checkSetter:(id)instance propertyName:(NSString *)propertyName;

@end
