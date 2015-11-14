//
//  RCFManagedObjectMappingProvider.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ManagedObjectMappingProvider.h"

#import <EasyMapping/EasyMapping.h>

#import "NSString+RCFCapitalization.h"

#import "SocialNetworkAccount.h"
#import "Event.h"

@implementation ManagedObjectMappingProvider

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
                            NSStringFromSelector(@selector(objectId)),
                            NSStringFromSelector(@selector(name)),
                            NSStringFromSelector(@selector(profileLink))
                            ];
    NSString *entityName = NSStringFromClass([SocialNetworkAccount class]);
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(objectId));
                                                  [mapping mapPropertiesFromArray:properties];
                                              }];
}

// TODO: It's just an example, the mapping is not finished yet
- (EKManagedObjectMapping *)eventMapping {
    NSArray *properties = @[
                            NSStringFromSelector(@selector(backgroundColor)),
                            NSStringFromSelector(@selector(eventDescription)),
                            NSStringFromSelector(@selector(liveStreamLink)),
                            NSStringFromSelector(@selector(name)),
                            NSStringFromSelector(@selector(objectId)),
                            NSStringFromSelector(@selector(tags)),
                            NSStringFromSelector(@selector(timePadID)),
                            NSStringFromSelector(@selector(twitterLink)),
                            ];
    NSString *entityName = NSStringFromClass([Event class]);
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(objectId));
                                                  [mapping mapPropertiesFromArray:properties];
                                                  [mapping mapKeyPath:@"image" toProperty:@"imageUrl" withValueBlock:^id(NSString *key, id value, NSManagedObjectContext *context) {
                                                      NSString *imageUrl;
                                                      if ([value isKindOfClass:[NSDictionary class]]) {
                                                          imageUrl = [value valueForKey:@"url"];
                                                      }
                                                      return imageUrl;
                                                  }];
                                                  EKManagedMappingValueBlock dateValueBlock = ^id(NSString *key, id value, NSManagedObjectContext *context) {
                                                      NSDate *date;
                                                      if ([value isKindOfClass:[NSDictionary class]]) {
                                                          NSString *dateString = [value objectForKey:@"iso"];
                                                          
                                                          NSDateFormatter *dateFormatter = [NSDateFormatter new];
                                                          [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
                                                          
                                                          date = [dateFormatter dateFromString:dateString];
                                                      }
                                                      return date;
                                                  };
                                                  
                                                  [mapping mapKeyPath:@"startDate" toProperty:@"startDate" withValueBlock:dateValueBlock];
                                                  [mapping mapKeyPath:@"endDate" toProperty:@"endDate" withValueBlock:dateValueBlock];
                                              }];
}

@end
