//
//  RCFManagedObjectMappingProvider.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFManagedObjectMappingProvider.h"

#import <EasyMapping/EasyMapping.h>

#import "NSString+RCFCapitalization.h"

#import "SocialNetworkAccount.h"

@implementation RCFManagedObjectMappingProvider

- (EKManagedObjectMapping *)mappingForManagedObjectModelClass:(Class)managedObjectModelClass {
    NSString *managedObjectModelStringName = NSStringFromClass(managedObjectModelClass);
    NSString *mappingName = [NSString stringWithFormat:@"%@Mapping", managedObjectModelStringName];
    NSString *decapitalizedMappingName = [mappingName rcf_decapitalizedStringSavingCase];
    
    EKManagedObjectMapping *selectedMapping = nil;
    SEL mappingSelector = NSSelectorFromString(decapitalizedMappingName);
    if ([self respondsToSelector:mappingSelector]) {
        selectedMapping = ((EKManagedObjectMapping* (*)(id, SEL))[self methodForSelector:mappingSelector])(self, mappingSelector);
    }
    return selectedMapping;
}

- (EKManagedObjectMapping *)socialNetworkAccountMapping {
    NSArray *properties = @[
                            NSStringFromSelector(@selector(name)),
                            NSStringFromSelector(@selector(profileLink))
                            ];
    NSString *entityName = NSStringFromClass([SocialNetworkAccount class]);
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  [mapping mapPropertiesFromArray:properties];
                                              }];
}

@end
