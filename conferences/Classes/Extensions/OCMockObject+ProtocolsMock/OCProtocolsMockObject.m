// Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "OCProtocolsMockObject.h"

@implementation OCProtocolsMockObject

#pragma mark  Initialisers, description, accessors, etc.

- (id)initWithProtocols:(NSArray<Protocol *> *)aProtocols
{
    NSParameterAssert(aProtocols != nil);
    self = [super init];
    mockedProtocols = aProtocols;
    return self;
}

- (NSString *)description {
    NSMutableArray *protocolNames = [NSMutableArray new];
    for (Protocol *protocol in mockedProtocols) {
        [protocolNames addObject:NSStringFromProtocol(protocol)];
    }
    return [NSString stringWithFormat:@"OCMockObject(%@)", protocolNames];
}

#pragma mark  Proxy API

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    for (Protocol *mockedProtocol in mockedProtocols) {
        struct { BOOL isRequired; BOOL isInstance; } opts[4] = { {YES, YES}, {NO, YES}, {YES, NO}, {NO, NO} };
        for(int i = 0; i < 4; i++)
        {
            struct objc_method_description methodDescription = protocol_getMethodDescription(mockedProtocol, aSelector, opts[i].isRequired, opts[i].isInstance);
            if(methodDescription.name != NULL)
                return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
        }
    }
    
    return nil;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    for (Protocol *mockedProtocol in mockedProtocols) {
        if (protocol_conformsToProtocol(mockedProtocol, aProtocol)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)respondsToSelector:(SEL)selector {
    return ([self methodSignatureForSelector:selector] != nil);
}

@end
