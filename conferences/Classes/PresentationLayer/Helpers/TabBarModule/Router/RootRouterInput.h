//
//  RootRouterInput.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 11/08/15.
//  Copyright 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRouterInput.h"

@protocol RootRouterInput <BaseRouterInput>

- (void)openTabWithIndex:(NSUInteger)tabIndex;

@end

