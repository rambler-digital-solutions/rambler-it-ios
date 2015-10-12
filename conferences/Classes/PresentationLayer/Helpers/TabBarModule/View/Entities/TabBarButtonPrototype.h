//
//  TabBarButtonPrototype.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 13/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarButtonPrototypeProtocol.h"

@interface TabBarButtonPrototype : NSObject<TabBarButtonPrototypeProtocol>

@property (nonatomic,strong) UIImage  *tabBarButtonIdleStateImage;
@property (nonatomic,strong) UIImage  *tabBarButtonSelectedStateImage;
@property (nonatomic,strong) NSString *tabBarButtonTitle;
@property (nonatomic,strong) NSString *tabbarButtonId;
@property (nonatomic,strong) id<TabBarControllerContent> tabBarControllercontent;

@end
