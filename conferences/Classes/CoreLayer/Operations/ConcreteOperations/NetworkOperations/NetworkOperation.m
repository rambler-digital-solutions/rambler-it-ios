//
//  NetworkOperation.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "NetworkOperation.h"

#import "NetworkClient.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

@interface NetworkOperation ()

@property (strong, nonatomic) id<NetworkClient> networkClient;

@end

@implementation NetworkOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithNetworkClient:(id<NetworkClient>)networkClient {
    self = [super init];
    if (self) {
        _networkClient = networkClient;
    }
    return self;
}

+ (instancetype)operationWithNetworkClient:(id<NetworkClient>)networkClient {
    return [[[self class] alloc] initWithNetworkClient:networkClient];
}

#pragma mark - Выполнение операции

- (void)main {
    DDLogVerbose(@"Начало выполнения операции %@", NSStringFromClass([self class]));
    NSURLRequest *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSURLRequest class]]) {
            DDLogVerbose(@"Входные данные операции %@ прошли валидацию", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"Входные данные операции %@ не прошли валидацию, класс данных: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Старт отправки запроса к серверу");
    @weakify(self);
    [self.networkClient sendRequest:inputData resultBlock:^(id data, NSError *error) {
        @strongify(self);
        if (error) {
            DDLogError(@"NetworkClient в операции %@ вернул ошибку: %@", NSStringFromClass([self class]), error);
        }
        if (data) {
            DDLogVerbose(@"Сервер вернул данные объемом: %li", [(NSData *)data length]);
        }
        
        [self completeOperationWithData:data error:error];
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
                                     [NSString stringWithFormat:@"Работает с клиентом: %@\n",
                                      [self.networkClient debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
