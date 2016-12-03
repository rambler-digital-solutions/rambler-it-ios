//
//  LectureMaterialDownloadingManager.m
//  Conferences
//
//  Created by Konstantin Zinovyev on 03.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureMaterialDownloadingManager.h"

@interface LectureMaterialDownloadingManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id <NSURLSessionDownloadDelegate>> *delegatesByIdentifier;

@end

@implementation LectureMaterialDownloadingManager

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _delegatesByIdentifier = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)updateDelegate:(id)delegate forURL:(NSString *)url {
    self.delegatesByIdentifier[url] = delegate;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    id delegate = self.delegatesByIdentifier[session.sessionDescription];
    [self.delegatesByIdentifier removeObjectForKey:session.sessionDescription];
    [delegate URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
    
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = [invocation selector];
    id argument = nil;
    [invocation getArgument:&argument atIndex:2];
    if (![argument isKindOfClass:[NSURLSession class]]) {
        return;
    }
    NSURLSession *session = argument;
    id delegate = self.delegatesByIdentifier[session.sessionDescription];
    if ([delegate respondsToSelector:selector]) {
        [invocation invokeWithTarget:delegate];
    }
}

@end
