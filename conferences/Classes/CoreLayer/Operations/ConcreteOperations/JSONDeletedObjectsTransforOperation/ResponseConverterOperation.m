//
//  JSONDeletedObjectsTransformOperation.m
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ResponseConverterOperation.h"
#import <CocoalumberJack/CocoaLumberjack.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface ResponseConverterOperation ()

@property (nonatomic, strong) id<ResponseConverter> responseConverter;

@end

@implementation ResponseConverterOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

- (instancetype)initWithResponseConverter:(id<ResponseConverter>)responseConverter {
    self = [super init];
    if (self) {
        _responseConverter = responseConverter;
    }
    return self;
}

+ (instancetype)operationWithResponseConverter:(id<ResponseConverter>)responseConverter {
    return [[[self class] alloc] initWithResponseConverter:responseConverter];
}

#pragma mark - Operation execution

- (void)main {
    DDLogVerbose(@"The operation %@ is started", NSStringFromClass([self class]));
    NSDictionary *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSDictionary class]] || data == nil) {
            DDLogVerbose(@"The input data for the operation %@ has passed the validation", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"The input data for the operation %@ hasn't passed the validation. The input data type is: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    NSDictionary *response =  [self.responseConverter convertFromResponse:inputData];
    
    DDLogVerbose(@"Successfully convert a response: %@", response);
    [self completeOperationWithData:response error:nil];
}

- (void)completeOperationWithData:(id)data error:(NSError *)error {
    if (data) {
        [self.output didCompleteChainableOperationWithOutputData:data];
        DDLogVerbose(@"The operation %@ output data has been passed to the buffer", NSStringFromClass([self class]));
    }
    
    [self.delegate didCompleteChainableOperationWithError:error];
    DDLogVerbose(@"The operation %@ is over", NSStringFromClass([self class]));
    [self complete];
}


@end
