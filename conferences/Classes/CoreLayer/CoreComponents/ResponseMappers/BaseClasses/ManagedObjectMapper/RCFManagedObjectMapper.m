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
#import "RCFResponseObjectFormatter.h"

static NSString *const kMappingContextManagedObjectClassKey = @"kMappingContextManagedObjectClassKey";

@interface RCFManagedObjectMapper ()

@property (strong, nonatomic) RCFManagedObjectMappingProvider *provider;
@property (strong, nonatomic) id<RCFResponseObjectFormatter> responseFormatter;

@end

@implementation RCFManagedObjectMapper

#pragma mark - Initialization

- (instancetype)initWithMappingProvider:(RCFManagedObjectMappingProvider *)mappingProvider
                responseObjectFormatter:(id<RCFResponseObjectFormatter>)formatter {
    self = [super init];
    if (self) {
        _provider = mappingProvider;
        _responseFormatter = formatter;
    }
    return self;
}

#pragma mark - RCFResponseMapper

- (id)mapServerResponse:(id)response
     withMappingContext:(NSDictionary *)context
                  error:(NSError *__autoreleasing *)error {
    if (self.responseFormatter) {
        response = [self.responseFormatter formatServerResponse:response];
    }
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    EKManagedObjectMapping *mapping = [self retreiveMappingForMappingContext:context];
    NSFetchRequest *request = [self createFetchRequestForMappingContext:context
                                                         managedContext:rootSavingContext];
    
    __block NSArray *result;
    [rootSavingContext performBlockAndWait:^{
        result = [EKManagedObjectMapper syncArrayOfObjectsFromExternalRepresentation:response
                                                                                  withMapping:mapping
                                                                                 fetchRequest:request
                                                                       inManagedObjectContext:rootSavingContext];
    }];
    
    return result;
}

#pragma mark - Helper Methods

- (EKManagedObjectMapping *)retreiveMappingForMappingContext:(NSDictionary *)mappingContext {
    Class managedObjectClass = NSClassFromString(mappingContext[kMappingContextManagedObjectClassKey]);
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:managedObjectClass];
    return mapping;
}

- (NSFetchRequest *)createFetchRequestForMappingContext:(NSDictionary *)mappingContext
                                         managedContext:(NSManagedObjectContext *)managedContext {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:mappingContext[kMappingContextManagedObjectClassKey]
                                   inManagedObjectContext:managedContext]];
    return request;
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
