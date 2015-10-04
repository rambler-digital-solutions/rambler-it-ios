//
//  RequestConfigurationOperation.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RequestConfigurationOperation.h"

#import "RequestConfigurator.h"
#import "RequestDataModel.h"

#import <CocoalumberJack/CocoaLumberjack.h>

@interface RequestConfigurationOperation ()

@property (strong, nonatomic) id<RequestConfigurator> requestConfigurator;
@property (strong, nonatomic) NSString *method;
@property (nonatomic) APIServiceType serviceType;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSArray *otherURLParts;

@end

@implementation RequestConfigurationOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Инициализация

- (instancetype)initWithRequestConfigurator:(id<RequestConfigurator>)configurator
                                     method:(NSString *)method
                                    service:(NSNumber *)service
                                     userID:(NSString *)userID
                              otherURLParts:(NSArray *)otherURLParts {
    self = [super init];
    if (self) {
        _requestConfigurator = configurator;
        _method = method;
        _serviceType = [service integerValue];
        _userID = userID;
        _otherURLParts = otherURLParts;
    }
    return self;
}

+ (instancetype)operationWithRequestConfigurator:(id<RequestConfigurator>)configurator
                                          method:(NSString *)method
                                         service:(NSNumber *)service
                                          userID:(NSString *)userID
                                   otherURLParts:(NSArray *)otherURLParts {
    return [[[self class] alloc] initWithRequestConfigurator:configurator
                                                      method:method
                                                     service:service
                                                      userID:userID
                                               otherURLParts:otherURLParts];
}

#pragma mark - Выполнение операции

- (void)main {
    DDLogVerbose(@"Начало выполнения операции %@", NSStringFromClass([self class]));
    RequestDataModel *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[RequestDataModel class]] || data == nil) {
            DDLogVerbose(@"Входные данные операции %@ прошли валидацию", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"Входные данные операции %@ не прошли валидацию, класс данных: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    NSURLRequest *request = [self.requestConfigurator requestWithMethod:self.method
                                                                service:self.serviceType
                                                          otherURLParts:self.otherURLParts
                                                                 userID:self.userID
                                                       requestDataModel:inputData];
    
    DDLogVerbose(@"Успешно создан сетевой запрос: %@", request);
    [self completeOperationWithData:request error:nil];
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
                                     [NSString stringWithFormat:@"Работает с конфигуратором: %@\n",
                                      [self.requestConfigurator debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
