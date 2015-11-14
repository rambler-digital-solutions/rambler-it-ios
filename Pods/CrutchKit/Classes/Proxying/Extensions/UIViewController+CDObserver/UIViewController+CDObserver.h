//
//  UIViewController+CDObserver.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 11/09/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CDObserver)

- (void)cd_startObserveProtocol:(Protocol *)protocol;

- (void)cd_stopObserve;

@end
