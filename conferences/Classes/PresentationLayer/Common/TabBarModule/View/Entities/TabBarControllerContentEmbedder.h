
#import <Foundation/Foundation.h>
#import "ModuleConfigurationPromiseProtocol.h"

@protocol TabBarControllerContent;

@protocol TabBarControllerContentEmbedder <NSObject>

- (id<ModuleConfigurationPromiseProtocol>)embedContent:(id<TabBarControllerContent>)content;

@end
