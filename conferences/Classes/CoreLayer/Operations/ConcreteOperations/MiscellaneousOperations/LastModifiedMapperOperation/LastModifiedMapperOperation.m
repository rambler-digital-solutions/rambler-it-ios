//
//  LastModifiedMapperOperation.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 15/02/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "LastModifiedMapperOperation.h"

#import <CocoalumberJack/CocoaLumberjack.h>

static NSString *const kLastModifiedHeaderKey = @"X-Last-Modified";

@interface LastModifiedMapperOperation ()

@property (nonatomic, strong) NSString *categoryObjectId;

@end

@implementation LastModifiedMapperOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithCategoryObjectId:(NSString *)categoryObjectId {
    self = [super init];
    if (self) {
        _categoryObjectId = categoryObjectId;
    }
    return self;
}

+ (instancetype)operationWithCategoryObjectId:(NSString *)categoryObjectId {
    return [[[self class] alloc] initWithCategoryObjectId:categoryObjectId];
}

#pragma mark - Выполнение операции

- (void)main {
//    ServerResponseModel *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
//        if ([data isKindOfClass:[ServerResponseModel class]]) {
//            DDLogVerbose(@"Входные данные операции %@ прошли валидацию", NSStringFromClass([self class]));
//            return YES;
//        }
//        DDLogVerbose(@"Входные данные операции %@ не прошли валидацию, класс данных: %@",
//                     NSStringFromClass([self class]),
//                     NSStringFromClass([data class]));
//        return NO;
//    }];
//    
//    __block NSError *error = nil;
//    NSHTTPURLResponse *serverResponse = inputData.response;
//    NSString *lastModifiedString = serverResponse.allHeaderFields[kLastModifiedHeaderKey];
//    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
//    [rootSavingContext performBlock:^{
//        NSManagedObjectID *categoryMOID = [NSManagedObjectID managedObjectIDFromString:self.categoryObjectId inContext:rootSavingContext];
//        PostCategoryModelObject *category = [rootSavingContext existingObjectWithID:categoryMOID
//                                                                              error:&error];
//        category.lastModified = lastModifiedString;
//        [rootSavingContext MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
//            if (error) {
//                DDLogError(@"Операция %@ вернула ошибку: %@", NSStringFromClass([self class]), error);
//            }
//            [self completeOperationWithData:inputData
//                                      error:error];
//        }];
//    }];
    
}

//- (void)completeOperationWithData:(ServerResponseModel *)data
//                            error:(NSError *)error {
//    if (data && data.data) {
//        [self.output didCompleteChainableOperationWithOutputData:data.data];
//        DDLogVerbose(@"Выходные данные операции %@ переданы буферу", NSStringFromClass([self class]));
//    }
//    
//    [self.delegate didCompleteChainableOperationWithError:error];
//    DDLogVerbose(@"Операция %@ завершена", NSStringFromClass([self class]));
//    [self complete];
//}

#pragma mark - Debug

- (NSString *)debugDescription {
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:nil];
}

@end
