//
//  ResponseMappingOperation.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ResponseMappingOperation.h"

#import "ResponseMapper.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

@interface ResponseMappingOperation ()

@property (strong, nonatomic) id<ResponseMapper> responseMapper;
@property (strong, nonatomic) NSDictionary *mappingContext;

@end

@implementation ResponseMappingOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithResponseMapper:(id<ResponseMapper>)responseMapper
                        mappingContext:(NSDictionary *)context {
    self = [super init];
    if (self) {
        _responseMapper = responseMapper;
        _mappingContext = context;
    }
    return self;
}

+ (instancetype)operationWithResponseMapper:(id<ResponseMapper>)responseMapper
                             mappingContext:(NSDictionary *)context {
    return [[[self class] alloc] initWithResponseMapper:responseMapper
                                         mappingContext:context];
}

#pragma mark - Выполнение операции

- (void)main {
    DDLogVerbose(@"Начало выполнения операции %@", NSStringFromClass([self class]));
    NSDictionary *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            DDLogVerbose(@"Входные данные операции %@ прошли валидацию", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"Входные данные операции %@ не прошли валидацию, класс данных: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Старт маппинга ответа сервера");
    NSError *mappingError = nil;
    id result = [self.responseMapper mapServerResponse:inputData withMappingContext:self.mappingContext error:&mappingError];
    if (mappingError) {
        DDLogError(@"ResponseMaper в операции %@ вернул ошибку: %@", NSStringFromClass([self class]), mappingError);
    }
    if (result) {
        DDLogVerbose(@"Успешно смапплены данные: %@", result);
    }
    
    [self completeOperationWithData:result error:mappingError];
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
                                     [NSString stringWithFormat:@"Работает с маппером: %@\n",
                                      [self.responseMapper debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
