//
//  LastModifiedMapperOperation.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 15/02/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "LastModifiedMapperOperation.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <MagicalRecord/MagicalRecord.h>

#import "NSManagedObjectID+LJStringConversion.h"

#import "ServerResponseModel.h"
#import "LastModifiedModelObject.h"

#import "DateFormatter.h"

static const int ddLogLevel = DDLogFlagVerbose;
static NSString *const kLastModifiedHeaderKey = @"Date";

@interface LastModifiedMapperOperation ()

@property (nonatomic, strong) NSString *modelObjectId;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation LastModifiedMapperOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithDateFormatter:(NSDateFormatter *)dateFormatter modelObjectId:(NSString *)modelObjectId {
    self = [super init];
    if (self) {
        _modelObjectId = modelObjectId;
        _dateFormatter = dateFormatter;
    }
    return self;
}

+ (instancetype)operationWithDateFormatter:(NSDateFormatter *)dateFormatter modelObjectId:(NSString *)modelObjectId {
    return [[[self class] alloc] initWithDateFormatter:dateFormatter modelObjectId:modelObjectId];
}

#pragma mark - Выполнение операции

- (void)main {
    ServerResponseModel *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[ServerResponseModel class]]) {
            DDLogVerbose(@"Входные данные операции %@ прошли валидацию", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"Входные данные операции %@ не прошли валидацию, класс данных: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    __block NSError *error = nil;
    if ([self.modelObjectId length] == 0) {
        [self completeOperationWithData:inputData
                                  error:error];
        return;
    }
    
    NSHTTPURLResponse *serverResponse = inputData.response;
    NSString *lastModifiedString = serverResponse.allHeaderFields[kLastModifiedHeaderKey];
    NSDate *lastModifiedDate = [self.dateFormatter dateFromString:lastModifiedString];
    
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlock:^{
        
        
        NSManagedObjectID *categoryMOID = [NSManagedObjectID managedObjectIDFromString:self.modelObjectId inContext:rootSavingContext];
        LastModifiedModelObject *modelObject = [rootSavingContext existingObjectWithID:categoryMOID
                                                                              error:&error];
        modelObject.lastModifiedDate = lastModifiedDate;
        
        [rootSavingContext MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
    
    
            if (error) {
                DDLogError(@"Операция %@ вернула ошибку: %@", NSStringFromClass([self class]), error);
            }
            [self completeOperationWithData:inputData
                                      error:error];
        }];
    }];

}

- (void)completeOperationWithData:(ServerResponseModel *)data
                            error:(NSError *)error {
    if (data && data.data) {
        [self.output didCompleteChainableOperationWithOutputData:data.data];
        DDLogVerbose(@"Выходные данные операции %@ переданы буферу", NSStringFromClass([self class]));
    }
    
    [self.delegate didCompleteChainableOperationWithError:error];
    DDLogVerbose(@"Операция %@ завершена", NSStringFromClass([self class]));
    [self complete];
}

#pragma mark - Debug

- (NSString *)debugDescription {
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:nil];
}

@end
