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

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "ApplicationAssembly.h"
#import "ApplicationAssembly_Testable.h"
#import "ServiceComponentsAssembly.h"

#import "AppDelegate.h"
#import "ApplicationConfiguratorImplementation.h"
#import "PushNotificationCenterImplementation.h"
#import "ThirdPartiesConfiguratorImplementation.h"

@interface ApplicationAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ApplicationAssembly *assembly;

@end

@implementation ApplicationAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [ApplicationAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[
                                                         [ServiceComponentsAssembly new]
                                                         ]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesAppDelegate {
    // given
    Class targetClass = [AppDelegate class];
    NSArray *dependencies = @[
                              RamblerSelector(applicationConfigurator),
                              RamblerSelector(pushNotificationCenter),
                              RamblerSelector(thirdPartiesConfigurator)
                              ];
    
    // when
    id result = [self.assembly appDelegate];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesApplicationConfigurator {
    // given
    Class targetClass = [ApplicationConfiguratorImplementation class];
    
    // when
    id result = [self.assembly applicationConfigurator];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesPushNotificationCenter {
    // given
    Class targetClass = [PushNotificationCenterImplementation class];
    NSArray *dependencies = @[
                              RamblerSelector(pushNotificationService)
                              ];
    
    // when
    id result = [self.assembly pushNotificationCenter];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesThirdPartiesConfigurator {
    // given
    Class targetClass = [ThirdPartiesConfiguratorImplementation class];
    
    // when
    id result = [self.assembly thirdPartiesConfigurator];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
