//
//  CDObserver.h
//  Pods
//
//  Created by Smal Vadim on 15/12/15.
//
//

#import <Foundation/Foundation.h>

@protocol CDObserver <NSObject>

@optional
- (BOOL)wantObserveSelector:(SEL)selector;

@end
