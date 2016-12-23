//
//  ROCMVerifier.m
//  RamblerTyphoonUtils
//
//  Created by Golovko Mikhail on 20/09/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "ROCMVerifier.h"
#import "TyphoonIntrospectionUtils.h"
#import "TyphoonTypeDescriptor.h"
#import "RamblerTyphoonAssemblyTestUtilities.h"
#import "RamblerTyphoonAssemblyTestsTypeDescriptor.h"
#import "OCMArg+Rambler.h"
#import "OCMock.h"

@implementation ROCMVerifier

+ (void)rds_checkSetter:(id)instance propertyName:(NSString *)propertyName {
    
    SEL setter = [RamblerTyphoonAssemblyTestUtilities  setterForPropertyWithName:propertyName
                                                                         inClass:[instance class]];
    NSDictionary *properties = [RamblerTyphoonAssemblyTestUtilities propertiesForHierarchyOfClass:[instance class]];
    NSString *propertyTypeString = properties[propertyName];
    RamblerPropertyType propertyType = [RamblerTyphoonAssemblyTestUtilities propertyTypeByString:propertyTypeString];
    OCMArg *arg;
    switch (propertyType) {
        case RamblerClass: {
            Class checkClass = NSClassFromString(propertyTypeString);
            arg = [OCMArg rds_checkConfirmToClass:checkClass];
            break;
        }
        case RamblerProtocol: {
            RamblerTyphoonAssemblyTestsTypeDescriptor *propertyTypeDescriptor =
            [RamblerTyphoonAssemblyTestUtilities typeDescriptorFromPropertyWithProtocol:propertyTypeString];
            arg = [OCMArg rds_checkConfirmToProtocolsArray:propertyTypeDescriptor.conformingProtocols];
            break;
        }
        default:
            arg = [OCMArg checkWithBlock:^BOOL(id obj) {
                return NO;
            }];
            break;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    OCMVerify([instance performSelector:setter withObject:arg]);
#pragma clang diagnostic pop
}

@end
