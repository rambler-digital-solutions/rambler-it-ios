//
//  ResponseMappingOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ResponseMappingOperation.h"

#import "RCFResponseMapper.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface ResponseMappingOperation ()

@property (strong, nonatomic) id<RCFResponseMapper> responseMapper;
@property (strong, nonatomic) NSDictionary *mappingContext;

@end

@implementation ResponseMappingOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Initialization

- (instancetype)initWithResponseMapper:(id<RCFResponseMapper>)responseMapper
                        mappingContext:(NSDictionary *)context {
    self = [super init];
    if (self) {
        _responseMapper = responseMapper;
        _mappingContext = context;
    }
    return self;
}

+ (instancetype)operationWithResponseMapper:(id<RCFResponseMapper>)responseMapper
                             mappingContext:(NSDictionary *)context {
    return [[[self class] alloc] initWithResponseMapper:responseMapper
                                         mappingContext:context];
}

#pragma mark - Operation execution

- (void)main {
    DDLogVerbose(@"The operation %@ is started", NSStringFromClass([self class]));
    NSDictionary *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            DDLogVerbose(@"The input data for the operation %@ has passed the validation", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"The input data for the operation %@ hasn't passed the validation. The input data type is: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Start mapping server response");
    NSError *mappingError = nil;
    id result = [self.responseMapper mapServerResponse:inputData withMappingContext:self.mappingContext error:&mappingError];
    if (mappingError) {
        DDLogError(@"ResponseMapper in operation %@ has produced error: %@", NSStringFromClass([self class]), mappingError);
    }
    if (result) {
        DDLogVerbose(@"Successfully mapped data: %@", result);
    }
    
    [self completeOperationWithData:result error:mappingError];
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

#pragma mark - Debug

- (NSString *)debugDescription {
    NSArray *additionalDebugInfo = @[
                                     [NSString stringWithFormat:@"Works with mapper: %@\n",
                                      [self.responseMapper debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
