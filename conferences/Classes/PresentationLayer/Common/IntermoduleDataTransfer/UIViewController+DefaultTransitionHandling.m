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

#import "UIViewController+DefaultTransitionHandling.h"
#import "ModuleConfigurationPromise.h"
#import "ModuleConfiguratorHolder.h"

@implementation UIViewController (DefaultTransitionHandling)

- (id<ModuleConfigurationPromiseProtocol>)default_performPromiseSegue:(NSString*)segueIdentifier withSender:(id)sender {
    ModuleConfigurationPromise *promise = [[ModuleConfigurationPromise alloc] init];
    [self performSegueWithIdentifier:segueIdentifier sender:@{
                                                              @"sender":sender,
                                                              @"promise":promise
                                                              }];
    return promise;
}

- (void)default_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[NSDictionary class]] && [segue.destinationViewController conformsToProtocol:@protocol(ModuleConfiguratorHolder)]) {
        ModuleConfigurationPromise * promise = sender[@"promise"];
        [promise setModuleConfigurator:[(id<ModuleConfiguratorHolder>)segue.destinationViewController moduleConfigurator]];
    }
}

- (void)default_embedViewController:(UIViewController*)viewController {
    [self addChildViewController:viewController];
    [viewController.view setFrame: self.view.bounds];
    [self.view addSubview: viewController.view];    
}

@end
