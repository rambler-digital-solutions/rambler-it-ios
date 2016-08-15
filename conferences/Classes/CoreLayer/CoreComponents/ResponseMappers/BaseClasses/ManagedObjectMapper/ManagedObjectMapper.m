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

#import "ManagedObjectMapper.h"

#import <EasyMapping/EasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

#import "ManagedObjectMappingProvider.h"
#import "ResponseObjectFormatter.h"
#import "EntityNameFormatter.h"
#import "NetworkingConstantsHeader.h"

@interface ManagedObjectMapper ()

@property (strong, nonatomic) ManagedObjectMappingProvider *provider;
@property (strong, nonatomic) id<ResponseObjectFormatter> responseFormatter;
@property (strong, nonatomic) id<EntityNameFormatter> entityNameFormatter;

@end

@implementation ManagedObjectMapper

#pragma mark - Initialization

- (instancetype)initWithMappingProvider:(ManagedObjectMappingProvider *)mappingProvider
                responseObjectFormatter:(id<ResponseObjectFormatter>)responseFormatter
                    entityNameFormatter:(id<EntityNameFormatter>)entityNameFormatter {
    self = [super init];
    if (self) {
        _provider = mappingProvider;
        _responseFormatter = responseFormatter;
        _entityNameFormatter = entityNameFormatter;
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
    
    __block NSArray *result;
    [rootSavingContext performBlockAndWait:^{
        result = [EKManagedObjectMapper arrayOfObjectsFromExternalRepresentation:response
                                                                     withMapping:mapping
                                                          inManagedObjectContext:rootSavingContext];
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    
    return result;
}

#pragma mark - Helper Methods

- (EKManagedObjectMapping *)retreiveMappingForMappingContext:(NSDictionary *)mappingContext {
    Class managedObjectClass = NSClassFromString(mappingContext[kMappingContextModelClassKey]);
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:managedObjectClass];
    return mapping;
}

- (NSFetchRequest *)createFetchRequestForMappingContext:(NSDictionary *)mappingContext
                                         managedContext:(NSManagedObjectContext *)managedContext {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *managedObjectClassName = mappingContext[kMappingContextModelClassKey];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:NSClassFromString(managedObjectClassName)];
    [request setEntity:[NSEntityDescription entityForName:entityName
                                   inManagedObjectContext:managedContext]];
    return request;
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
