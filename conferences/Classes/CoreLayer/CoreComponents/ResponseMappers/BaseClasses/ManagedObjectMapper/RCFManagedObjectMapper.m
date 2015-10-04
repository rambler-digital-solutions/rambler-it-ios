//
//  RCFManagedObjectMapper.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFManagedObjectMapper.h"

#import <EasyMapping/EasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

#import "RCFManagedObjectMappingProvider.h"

static NSString *const kMappingContextManagedObjectClassKey = @"kMappingContextManagedObjectClassKey";

@interface RCFManagedObjectMapper ()

@property (strong, nonatomic) RCFManagedObjectMappingProvider *provider;

@end

@implementation RCFManagedObjectMapper

#pragma mark - Initialization

- (instancetype)initWithMappingProvider:(RCFManagedObjectMappingProvider *)mappingProvider {
    self = [super init];
    if (self) {
        _provider = mappingProvider;
    }
    return self;
}

#pragma mark - RCFResponseMapper

- (id)mapServerResponse:(NSDictionary *)response
     withMappingContext:(NSDictionary *)context
                  error:(NSError *__autoreleasing *)error {
    NSArray *objects = response[@"results"];
    
    Class managedObjectClass = NSClassFromString(context[kMappingContextManagedObjectClassKey]);
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:managedObjectClass];
    
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:context[kMappingContextManagedObjectClassKey]
                                   inManagedObjectContext:rootSavingContext]];
    
    __block NSArray *result;
    [rootSavingContext performBlockAndWait:^{
        result = [EKManagedObjectMapper syncArrayOfObjectsFromExternalRepresentation:objects
                                                                                  withMapping:mapping
                                                                                 fetchRequest:request
                                                                       inManagedObjectContext:rootSavingContext];
    }];
    
    return result;
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
