//
//  TabBarButtonPrototypeProtocol.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 11/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDSModuleConfigurationPromiseProtocol.h"

@protocol TabBarControllerContent;

@protocol TabBarButtonPrototypeProtocol <NSObject>

- (UIImage*)tabBarButtonIdleStateImage;
- (UIImage*)tabBarButtonSelectedStateImage;
- (NSString*)tabBarButtonTitle;
- (NSString*)tabbarButtonId;
- (id<TabBarControllerContent>)tabBarControllercontent;

@end
