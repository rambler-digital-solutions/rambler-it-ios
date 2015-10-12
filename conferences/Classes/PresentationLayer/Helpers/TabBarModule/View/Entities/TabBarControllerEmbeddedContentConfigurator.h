//
//  TabBarControllerEmbeddedContentConfigurator.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 11/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDSModuleConfiguratorProtocol.h"

@protocol TabBarControllerEmbeddedContentConfigurator <RDSModuleConfiguratorProtocol>

- (void)configureWithTagBarButtonId:(NSString*)tabBarButtonId;

@end
