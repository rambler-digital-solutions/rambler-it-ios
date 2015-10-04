//
//  ResponseValidationOperation.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ResponseValidationOperation.h"

#import "RCFResponseValidator.h"

#import <CocoalumberJack/CocoaLumberjack.h>

@interface ResponseValidationOperation ()

@property (strong, nonatomic) id<ResponseValidator> responseValidator;

@end

@implementation ResponseValidationOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithResponseValidator:(id<ResponseValidator>)responseValidator {
    self = [super init];
    if (self) {
        _responseValidator = responseValidator;
    }
    return self;
}

+ (instancetype)operationWithResponseValidator:(id<ResponseValidator>)responseValidator {
    return [[[self class] alloc] initWithResponseValidator:responseValidator];
}

#pragma mark - Выполнение операции

- (void)main {
    DDLogVerbose(@"Начало выполнения операции %@", NSStringFromClass([self class]));
    id inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if (data) {
            DDLogVerbose(@"Входные данные операции %@ прошли валидацию", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"Входные данные операции %@ не прошли валидацию, класс данных: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Старт валидации ответа сервера");
    NSError *validationError = [self.responseValidator validateServerResponse:inputData];
    if (validationError) {
        DDLogError(@"ResponseValidator в операции %@ вернул ошибку: %@", NSStringFromClass([self class]), validationError);
    }
    
    [self completeOperationWithData:inputData error:validationError];
}

- (void)completeOperationWithData:(id)data error:(NSError *)error {
    if (data) {
        [self.output didCompleteChainableOperationWithOutputData:data];
        DDLogVerbose(@"Выходные данные операции %@ переданы буферу", NSStringFromClass([self class]));
    }
    
    [self.delegate didCompleteChainableOperationWithError:error];
    DDLogVerbose(@"Операция %@ завершена", NSStringFromClass([self class]));
    [self complete];
}

#pragma mark - Debug

- (NSString *)debugDescription {
    NSArray *additionalDebugInfo = @[
                                     [NSString stringWithFormat:@"Работает с валидатором: %@\n",
                                      [self.responseValidator debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
