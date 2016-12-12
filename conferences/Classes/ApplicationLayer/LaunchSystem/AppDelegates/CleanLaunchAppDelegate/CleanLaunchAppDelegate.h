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

#import <UIKit/UIKit.h>

@protocol ApplicationConfigurator;
@protocol ThirdPartiesConfigurator;
@protocol SpotlightCoreDataStackCoordinator;
@protocol Daemon;
@class IndexerMonitor;
@class CleanLaunchRouter;
@class SpotlightImageIndexer;

/**
 @author Egor Tolstoy
 
 This AppDelegate is responsible for clean application start
 */
@interface CleanLaunchAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) id <ApplicationConfigurator> applicationConfigurator;
@property (nonatomic, strong) id <ThirdPartiesConfigurator> thirdPartiesConfigurator;
@property (nonatomic, strong) id <Daemon> quickActionDaemon;
@property (nonatomic, strong) IndexerMonitor *indexerMonitor;
@property (nonatomic, strong) CleanLaunchRouter *cleanStartRouter;
@property (nonatomic, strong) id<SpotlightCoreDataStackCoordinator> spotlightCoreDataStackCoordinator;
@property (nonatomic, strong) SpotlightImageIndexer *imageIndexer;

@end
