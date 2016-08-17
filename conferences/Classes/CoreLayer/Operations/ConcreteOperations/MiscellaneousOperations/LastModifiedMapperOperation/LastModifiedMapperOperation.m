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
