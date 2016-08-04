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

#import "ApplicationAssembly.h"

#import "ApplicationConfigurator.h"
#import "ApplicationConfiguratorImplementation.h"
#import "AppDelegate.h"
#import "PushNotificationCenter.h"
#import "PushNotificationCenterImplementation.h"
#import "ServiceComponents.h"
#import "ThirdPartiesConfigurator.h"
#import "ThirdPartiesConfiguratorImplementation.h"
#import "SpotlightIndexerAssembly.h"

@implementation ApplicationAssembly

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(applicationConfigurator)
                                                    with:[self applicationConfigurator]];
                              [definition injectProperty:@selector(pushNotificationCenter)
                                                    with:[self pushNotificationCenter]];
                              [definition injectProperty:@selector(thirdPartiesConfigurator)
                                                    with:[self thirdPartiesConfigurator]];
                              [definition injectProperty:@selector(indexerMonitor)
                                                    with:[self.spotlightIndexerAssembly indexerMonitor]];
    }];
}

- (id <ApplicationConfigurator>)applicationConfigurator {
    return [TyphoonDefinition withClass:[ApplicationConfiguratorImplementation class]];
}

- (id <PushNotificationCenter>)pushNotificationCenter {
    return [TyphoonDefinition withClass:[PushNotificationCenterImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(pushNotificationService)
                                                    with:[self.serviceComponents pushNotificationService]];
    }];
}

- (id <ThirdPartiesConfigurator>)thirdPartiesConfigurator {
    return [TyphoonDefinition withClass:[ThirdPartiesConfiguratorImplementation class]];
}

@end
