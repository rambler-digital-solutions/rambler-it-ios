//
//  LectureMaterialDownloadingManager.m
//  Conferences
//
//  Created by Konstantin Zinovyev on 03.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureMaterialDownloadingManager.h"
#import <objc/runtime.h>

@interface LectureMaterialDownloadingManager ()

@property (nonatomic, strong) NSMapTable<NSString *, id <NSURLSessionDownloadDelegate>> *delegatesByIdentifier;

@end

@implementation LectureMaterialDownloadingManager

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _delegatesByIdentifier = [[NSMapTable alloc] init];
        
    }
    
    return self;
}

- (void)registerDelegate:(id)delegate forURL:(NSString *)url {
    __weak id weakDelegate = delegate;
    [self.delegatesByIdentifier setObject:weakDelegate forKey:url];
}

- (void)updateDelegate:(id)delegate forURL:(NSString *)url {
    __weak id weakDelegate = delegate;
    id storedDelegate = [self.delegatesByIdentifier objectForKey:url];
    if (storedDelegate) {
        [self.delegatesByIdentifier setObject:weakDelegate forKey:url];
    }
}

// TODO: записывать в нормальный путь
// TODO: сохранять в базу (проблема с completionBlock)
// TODO: удалять по всем завершающим операциям

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    [self.delegatesByIdentifier removeObjectForKey:session.sessionDescription];
    [delegate URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    [self.delegatesByIdentifier removeObjectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]) {
        [delegate URLSession:session task:task didCompleteWithError:error];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self selector_belongsToProtocol:aSelector protocol:@protocol(NSURLSessionDownloadDelegate)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [LectureMaterialDownloadingManager instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = [invocation selector];
    id argument = nil;
    [invocation getArgument:&argument atIndex:2];
    if (![argument isKindOfClass:[NSURLSession class]]) {
        return;
    }
    NSURLSession *session = argument;
    id delegate = [self.delegatesByIdentifier objectForKey:session.sessionDescription];
    if ([delegate respondsToSelector:selector]) {
        [invocation invokeWithTarget:delegate];
    }
}

#pragma mark - Private methods 

// в категорию
- (BOOL)selector_belongsToProtocol:(SEL)selector protocol:(Protocol *)protocol {
    for (int optionbits = 0; optionbits < (1 << 2); optionbits++) {
        BOOL required = optionbits & 1;
        BOOL instance = !(optionbits & (1 << 1));
        
        struct objc_method_description hasMethod = protocol_getMethodDescription(protocol, selector, required, instance);
        if (hasMethod.name || hasMethod.types) {
            return YES;
        }
    }
    return NO;
}

@end
