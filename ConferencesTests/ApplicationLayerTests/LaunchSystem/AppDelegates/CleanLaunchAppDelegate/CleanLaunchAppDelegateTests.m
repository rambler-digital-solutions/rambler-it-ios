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
#import <OCMock/OCMock.h>

#import "CleanLaunchAppDelegate.h"

#import "ApplicationConfigurator.h"
#import "ThirdPartiesConfigurator.h"
#import "IndexerMonitor.h"
#import "SpotlightCoreDataStackCoordinator.h"
#import "CleanLaunchRouter.h"
#import "SpotlightImageIndexer.h"

@interface CleanLaunchAppDelegateTests : XCTestCase

@property (nonatomic, strong) CleanLaunchAppDelegate *appDelegate;
@property (nonatomic, strong) id mockApplicationConfigurator;
@property (nonatomic, strong) id mockThirdPartiesConfigurator;
@property (nonatomic, strong) id mockIndexerMonitor;
@property (nonatomic, strong) id mockSpotlightCoreDataStackCoordinator;
@property (nonatomic, strong) id mockCleanStartRouter;
@property (nonatomic, strong) id mockImageIndexer;

@end

@implementation CleanLaunchAppDelegateTests

- (void)setUp {
    [super setUp];
    
    self.appDelegate = [CleanLaunchAppDelegate new];
    
    self.mockApplicationConfigurator = OCMProtocolMock(@protocol(ApplicationConfigurator));
    self.mockThirdPartiesConfigurator = OCMProtocolMock(@protocol(ThirdPartiesConfigurator));
    self.mockIndexerMonitor = OCMClassMock([IndexerMonitor class]);
    self.mockSpotlightCoreDataStackCoordinator = OCMProtocolMock(@protocol(SpotlightCoreDataStackCoordinator));
    self.mockCleanStartRouter = OCMClassMock([CleanLaunchRouter class]);
    self.mockImageIndexer = OCMClassMock([SpotlightImageIndexer class]);
    self.appDelegate.applicationConfigurator = self.mockApplicationConfigurator;
    self.appDelegate.thirdPartiesConfigurator = self.mockThirdPartiesConfigurator;
    self.appDelegate.indexerMonitor = self.mockIndexerMonitor;
    self.appDelegate.spotlightCoreDataStackCoordinator = self.mockSpotlightCoreDataStackCoordinator;
    self.appDelegate.cleanStartRouter = self.mockCleanStartRouter;
}

- (void)tearDown {
    self.appDelegate = nil;
    
    self.mockApplicationConfigurator = nil;
    self.mockThirdPartiesConfigurator = nil;
    self.mockSpotlightCoreDataStackCoordinator = nil;
    
    [self.mockIndexerMonitor stopMocking];
    self.mockIndexerMonitor = nil;
    
    [self.mockImageIndexer stopMocking];
    self.mockImageIndexer = nil;
    
    [self.mockCleanStartRouter stopMocking];
    self.mockCleanStartRouter = nil;
    
    [super tearDown];
}

- (void)testThatAppDelegateTriggersAllDependenciesOnStart {
    // given
    id mockApplication = [NSObject new];
    
    // when
    [self.appDelegate application:mockApplication didFinishLaunchingWithOptions:nil];
    
    // then
    OCMVerify([self.mockThirdPartiesConfigurator configurate]);
    OCMVerify([self.mockApplicationConfigurator setupCoreDataStack]);
    OCMVerify([self.mockSpotlightCoreDataStackCoordinator setupCoreDataStack]);
    OCMVerify([self.mockIndexerMonitor startMonitoring]);
    OCMVerify([self.mockCleanStartRouter openInitialScreen]);
    OCMVerify([self.mockImageIndexer startIndexImageForSpotlight]);
}

@end
