//
//  DeletedObjectsMapper.m
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "DeletedObjectsMapper.h"
#import "CustomServerResponse.h"
#import "NetworkingConstantsHeader.h"

#import <EasyMapping/EasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>
#import "ManagedObjectMappingProvider.h"

@implementation DeletedObjectsMapper

- (instancetype)initWithMappingProvider:(ManagedObjectMappingProvider *)mappingProvider
                responseObjectFormatter:(id<ResponseObjectFormatter>)responseFormatter
                    entityNameFormatter:(id<EntityNameFormatter>)entityNameFormatter {
    self = [super init];
    if (self) {
        _provider = mappingProvider;
        _deletedResponseFormatter = responseFormatter;
        _entityNameFormatter = entityNameFormatter;
    }
    return self;
}

- (id)mapServerResponse:(id)response
     withMappingContext:(NSDictionary *)context
                  error:(NSError *__autoreleasing *)error {
    CustomServerResponse *customResponse;
    customResponse = [self.deletedResponseFormatter formatServerResponse:response];
    
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    EKManagedObjectMapping *mapping = [self retreiveMappingForMappingContext:context];
    
    [self deleteObjects:customResponse.deletedObjects
            withMapping:mapping
          objectContext:rootSavingContext];
    
    NSArray *result = [self updateObjects:customResponse.updatedObjects
                              withMapping:mapping
                            objectContext:rootSavingContext];
    
    return result;
}

#pragma mark - private methods

-(void)deleteObjects:(NSArray *)objects
         withMapping:(EKManagedObjectMapping *)mapping
       objectContext:(NSManagedObjectContext*)context {
    for (NSDictionary *object in objects) {
        id managedObject = [EKManagedObjectMapper objectFromExternalRepresentation:object
                                                                       withMapping:mapping
                                                            inManagedObjectContext:context];
        [managedObject MR_deleteEntity];
    }
}

-(NSArray *)updateObjects:(NSArray *)objects
         withMapping:(EKManagedObjectMapping *)mapping
       objectContext:(NSManagedObjectContext*)context {
    __block NSArray *result;
    [context performBlockAndWait:^{
        result = [EKManagedObjectMapper arrayOfObjectsFromExternalRepresentation:objects
                                                                     withMapping:mapping
                                                          inManagedObjectContext:context];
        [context MR_saveToPersistentStoreAndWait];
    }];
    
    return result;
}

- (EKManagedObjectMapping *)retreiveMappingForMappingContext:(NSDictionary *)mappingContext {
    Class managedObjectClass = NSClassFromString(mappingContext[kMappingContextModelClassKey]);
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:managedObjectClass];
    return mapping;
}

@end
