
// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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