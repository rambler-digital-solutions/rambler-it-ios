
#import <Foundation/Foundation.h>
#import "TabBarRouterInput.h"

@protocol TabBarControllerContentEmbedder;

@interface TabBarRouter : NSObject <TabBarRouterInput>

@property (nonatomic,weak) id<TabBarControllerContentEmbedder> tabBarControllerContentEmbedder;

@property (nonatomic,strong) NSArray *tabFactories;

@end