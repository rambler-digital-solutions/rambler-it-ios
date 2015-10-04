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
    
    Class managedObjectClass = NSClassFromString(context[kMappingContextManagedObjectClassKey]);
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:managedObjectClass];
    
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:context[kMappingContextManagedObjectClassKey]
                                   inManagedObjectContext:rootSavingContext]];
    
    __block NSArray *result;
    [rootSavingContext performBlockAndWait:^{
        result = [EKManagedObjectMapper syncArrayOfObjectsFromExternalRepresentation:response
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
