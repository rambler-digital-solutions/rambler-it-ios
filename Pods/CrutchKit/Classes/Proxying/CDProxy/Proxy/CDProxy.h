//
//  CDProxy.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 09/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CDProxy <NSObject>

- (BOOL)respondsToSelector:(SEL)selector
              fromProtocol:(Protocol *)protocol
                fromSender:(id)sender;

- (NSArray *)proxyProtocols;

- (id)unwrap;

@end
