//
//  RequestSigningOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RequestSigningOperation.h"

#import "RequestSigner.h"

#import <CocoalumberJack/CocoaLumberjack.h>
#import <libextobjc/EXTScope.h>

static const int ddLogLevel = DDLogLevelVerbose;

@interface RequestSigningOperation ()

@property (strong, nonatomic) id<RequestSigner> requestSigner;

@end

@implementation RequestSigningOperation

@synthesize delegate = _delegate;
@synthesize input = _input;
@synthesize output = _output;

#pragma mark - Initialization

- (instancetype)initWithRequestSigner:(id<RequestSigner>)signer {
    self = [super init];
    if (self) {
        _requestSigner = signer;
    }
    return self;
}

+ (instancetype)operationWithRequestSigner:(id<RequestSigner>)signer {
    return [[[self class] alloc] initWithRequestSigner:signer];
}

#pragma mark - Operation execution

- (void)main {
    DDLogVerbose(@"The operation %@ is started", NSStringFromClass([self class]));
    NSURLRequest *inputData = [self.input obtainInputDataWithTypeValidationBlock:^BOOL(id data) {
        if ([data isKindOfClass:[NSURLRequest class]]) {
            DDLogVerbose(@"The input data for the operation %@ has passed the validation", NSStringFromClass([self class]));
            return YES;
        }
        DDLogVerbose(@"The input data for the operation %@ hasn't passed the validation. The input data type is: %@",
                     NSStringFromClass([self class]),
                     NSStringFromClass([data class]));
        return NO;
    }];
    
    DDLogVerbose(@"Start signing the request");
    NSURLRequest *signedRequest = [self.requestSigner signRequest:inputData];
    DDLogVerbose(@"The request was successfully signed: %@", signedRequest);

    [self completeOperationWithData:signedRequest error:nil];
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
                                     [NSString stringWithFormat:@"Works with signer: %@\n",
                                      [self.requestSigner debugDescription]]
                                     ];
    return [OperationDebugDescriptionFormatter debugDescriptionForOperation:self
                                                         withAdditionalInfo:additionalDebugInfo];
}

@end
