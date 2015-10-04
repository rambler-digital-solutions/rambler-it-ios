//
//  ResponseDeserializationOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ResponseDeserializationOperation.h"

#import "RCFResponseDeserializer.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface ResponseDeserializationOperation ()

@property (strong, nonatomic) id<RCFResponseDeserializer> responseDeserializer;

@end

@implementation ResponseDeserializationOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithResponseDeserializer:(id<RCFResponseDeserializer>)responseDeserializer {
    self = [super init];
    if (self) {
        _responseDeserializer = responseDeserializer;
    }
    return self;
}

+ (instancetype)operationWithResponseDeserializer:(id<RCFResponseDeserializer>)responseDeserializer {
    return [[[self class] alloc] initWithResponseDeserializer:responseDeserializer];
}

#pragma mark - Выполнение операции

- (void)main {
    DDLogVerbose(@"Начало выполнения операции %@", NSStringFromClass([self class]));
    NSData *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSData class]]) {
            DDLogVerbose(@"Входные данные операции %@ прошли валидацию", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"Входные данные операции %@ не прошли валидацию, класс данных: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Старт действия десериализации ответа сервера");
    @weakify(self);
    [self.responseDeserializer deserializeServerResponse:inputData completionBlock:^(NSDictionary *response, NSError *error) {
        @strongify(self);
        if (error) {
            DDLogError(@"ResponseDeserializer в операции %@ вернул ошибку: %@", NSStringFromClass([self class]), error);
        }
        if (response) {
            DDLogVerbose(@"Успешно десериализован ответ сервера: %@", response);
        }
        
        [self completeOperationWithData:response error:error];
    }];
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
                                     [NSString stringWithFormat:@"Работает с десериализатором: %@\n",
                                      [self.responseDeserializer debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
