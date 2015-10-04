//
//  RequestSigningOperation.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 04/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RequestSigningOperation.h"

#import "RequestSigner.h"
#import "Session.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

@interface RequestSigningOperation ()

@property (strong, nonatomic) id<RequestSigner> requestSigner;
@property (strong, nonatomic) id<Session> session;

@end

@implementation RequestSigningOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithRequestSigner:(id<RequestSigner>)signer session:(id<Session>)session {
    self = [super init];
    if (self) {
        _requestSigner = signer;
        _session = session;
    }
    return self;
}

+ (instancetype)operationWithRequestSigner:(id<RequestSigner>)signer session:(id<Session>)session {
    return [[[self class] alloc] initWithRequestSigner:signer
                                               session:session];
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
    
    DDLogVerbose(@"Старт действия подписывания сетевого запроса");
    @weakify(self);
    [self.requestSigner signRequest:inputData forSession:self.session resultBlock:^(NSURLRequest *signedRequest, NSError *error) {
        @strongify(self);
        if (error) {
            DDLogError(@"RequestSigner в операции %@ вернул ошибку: %@", NSStringFromClass([self class]), error);
        }
        if (signedRequest) {
            DDLogVerbose(@"Успешно подписан сетевой запрос: %@", signedRequest);
        }
        
        [self completeOperationWithData:signedRequest error:error];
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
                                     [NSString stringWithFormat:@"Работает с подписывателем: %@\n",
                                      [self.requestSigner debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
