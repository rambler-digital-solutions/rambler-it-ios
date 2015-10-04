//
//  RequestSigningOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RequestSigningOperation.h"

#import "RCFRequestSigner.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface RequestSigningOperation ()

@property (strong, nonatomic) id<RCFRequestSigner> requestSigner;

@end

@implementation RequestSigningOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithRequestSigner:(id<RCFRequestSigner>)signer {
    self = [super init];
    if (self) {
        _requestSigner = signer;
    }
    return self;
}

+ (instancetype)operationWithRequestSigner:(id<RCFRequestSigner>)signer {
    return [[[self class] alloc] initWithRequestSigner:signer];
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
    NSURLRequest *signedRequest = [self.requestSigner signRequest:inputData];
    DDLogVerbose(@"Успешно подписан сетевой запрос: %@", signedRequest);

    [self completeOperationWithData:signedRequest error:nil];
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
