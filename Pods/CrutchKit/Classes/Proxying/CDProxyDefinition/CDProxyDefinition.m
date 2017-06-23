//
//  CDProxyDefinition.m
//  Pods
//
//  Created by Smal Vadim on 15/12/15.
//
//

#import "CDProxyDefinition.h"
#import "CDObserver.h"
#import "CDProtocol.h"

@interface CDProxyDefinition ()

@property (strong, nonatomic, readwrite) NSHashTable *observers;
@property (strong, nonatomic, readwrite) NSArray *protocols;

@end

@implementation CDProxyDefinition

- (instancetype)initWithProtocols:(NSArray *)protocols
                        observers:(NSArray *)observers {
    
    self = [super init];
    
    if (self) {
        
        _protocols = protocols;
        
        _observers = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        
        for (id observer in observers) {
            
            [self addObserver:observer];
            
        }
        
    }
    
    return self;
}

+ (instancetype)definitionWithProtocols:(NSArray *)protocols {
    return [[self alloc] initWithProtocols:protocols
                                 observers:nil];
}

+ (instancetype)definitionWithProtocols:(NSArray *)protocols
                              observers:(NSArray *)observers {
    return [[self alloc] initWithProtocols:protocols
                                 observers:observers];
}

- (NSArray *)proxyProtocols {
    return [self.protocols copy];
}

- (NSArray *)proxyObservers {
    return [self.observers allObjects];
}

- (void)addObserver:(id<CDObserver>)observer {
    
    @synchronized(self) {
        
        for (Protocol *protocol in self.protocols) {
            if ([observer conformsToProtocol:protocol]) {
                [_observers addObject:observer];
                return;
            }
        }
        [NSException raise:NSInvalidArgumentException
                    format:@"Observer %@ not conform to any protocol %@", observer, self.proxyProtocols];
    
    }
    
}

- (void)removeObserver:(id)observer {
    
    @synchronized(self) {
        
        [_observers removeObject:observer];
        
    }
    
}

@end
