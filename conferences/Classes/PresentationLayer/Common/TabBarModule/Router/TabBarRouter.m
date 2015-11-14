
#import "TabBarRouter.h"
#import "TabBarButtonPrototypeProtocol.h"
#import "TabBarControllerContentEmbedder.h"
#import "TabBarControllerEmbeddedContentConfigurator.h"

@interface TabBarRouter()

@property (nonatomic,strong) NSMutableDictionary *contentCache;

@end

@implementation TabBarRouter

#pragma mark - RootRouterInput

- (instancetype)init {
    self = [super init];
    if (self) {
        _contentCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)openTabWithIndex:(NSUInteger)tabIndex {
    id<TabBarButtonPrototypeProtocol> prototype = self.tabFactories[tabIndex];
    
    id<TabBarControllerContent> content = self.contentCache[[prototype tabbarButtonId]];
    if (content == nil) {
        content = [prototype tabBarControllercontent];
    }
    [[self.tabBarControllerContentEmbedder embedContent:content]
     thenConfigureModuleWithBlock:^(id<TabBarControllerEmbeddedContentConfigurator> rccModuleConfigurator) {
         [rccModuleConfigurator configureWithTagBarButtonId:[prototype tabbarButtonId]];
    }];
}

@end