//
//  RCFManagedObjectMappingProvider.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFManagedObjectMappingProvider.h"

#import <EasyMapping/EasyMapping.h>

#import "SocialNetworkAccount.h"

@implementation RCFManagedObjectMappingProvider

+ (EKManagedObjectMapping *)socialNetworkModelMapping {
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
