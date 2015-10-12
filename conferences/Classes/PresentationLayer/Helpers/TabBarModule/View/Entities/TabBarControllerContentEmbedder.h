//
//  TabBarControllerContentEmbedder.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 11/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDSModuleConfigurationPromiseProtocol.h"

@protocol TabBarControllerContent;

@protocol TabBarControllerContentEmbedder <NSObject>

- (id<RDSModuleConfigurationPromiseProtocol>)embedContent:(id<TabBarControllerContent>)content;

@end
