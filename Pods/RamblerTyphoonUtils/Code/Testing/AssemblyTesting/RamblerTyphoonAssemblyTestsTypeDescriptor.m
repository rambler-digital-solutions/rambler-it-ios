//
//  RamblerTyphoonAssemblyTestsTypeDescriptor.m
//  RamblerTyphoonUtils
//
//  Created by Aleksandr Sychev on 10.01.16.
//  Copyright © 2016 Egor Tolstoy. All rights reserved.
//

#import "RamblerTyphoonAssemblyTestsTypeDescriptor.h"

@implementation RamblerTyphoonAssemblyTestsTypeDescriptor

#pragma mark - Properties

- (Class)describedClass {
    if (_describedClass == Nil) {
        return [NSObject class];
    }
    return _describedClass;
}

#pragma mark - Init

+ (instancetype)descriptorWithClass:(Class)describedClass {
    return [[self class] descriptorWithClass:describedClass
                                andProtocols:nil];
}

- (instancetype)initWithClass:(Class)describedClass {
    return [self initWithClass:describedClass
                  andProtocols:nil];
}

+ (instancetype)descriptorWithProtocols:(NSArray *)conformingProtocols {
    return [[self class] descriptorWithClass:Nil
                                andProtocols:conformingProtocols];
}

- (instancetype)initWithProtocols:(NSArray *)conformingProtocols {
    return [self initWithClass:Nil
                  andProtocols:conformingProtocols];
}

+ (instancetype)descriptorWithClass:(Class)describedClass
                       andProtocols:(NSArray *)conformingProtocols {
    return [[[self class] alloc] initWithClass:describedClass
                                  andProtocols:conformingProtocols];
}

- (instancetype)initWithClass:(Class)describedClass
                 andProtocols:(NSArray *)conformingProtocols {
    self = [super init];
    if (self) {
        _describedClass = describedClass;
        _conformingProtocols = [conformingProtocols copy];
    }
    return self;
}

@end
