// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
