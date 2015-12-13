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

#import "TabBarViewController.h"
#import "TabBarViewOutput.h"
#import "CollectionViewDataDisplayManager.h"
#import "TabBarButtonCell.h"
#import "TabBarControllerContent.h"
#import "ModuleConfigurationPromise.h"
#import <PureLayout/PureLayout.h>

@interface TabBarViewController()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIViewController *currentContentViewController;
@property (nonatomic,strong) CollectionViewDataDisplayManager *tabsDDM;
@property (nonatomic,strong) UIView *defaultTitleView;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
    self.defaultTitleView = self.navigationItem.titleView;
}

#pragma mark - RootViewInput

- (void)showTabs:(NSArray*)tabs {
    self.tabsDDM = [[CollectionViewDataDisplayManager alloc] initWithFlatListCellObjects:tabs];
    self.tabsDDM.cellReuseId = NSStringFromClass([TabBarButtonCell class]);
    self.tabButtonsCollectionView.dataSource = self.tabsDDM;
    [self.tabButtonsCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                                animated:NO
                                          scrollPosition:UICollectionViewScrollPositionNone];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.tabButtonsCollectionView.collectionViewLayout;
    CGSize itemSize = flowLayout.itemSize;
    itemSize.width = self.view.frame.size.width/tabs.count;
    flowLayout.itemSize = itemSize;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.output selectedTabWithIndex:indexPath.row];
}

#pragma mark - TabBarControllerContentEmbedder

- (id<ModuleConfigurationPromiseProtocol>)embedContent:(id<TabBarControllerContent>)content {
    
    if (self.currentContentViewController != nil) {
        [self.currentContentViewController.view removeFromSuperview];
        [self.currentContentViewController removeFromParentViewController];
    }
    
    UIViewController *controller = [content viewController];
    [self addChildViewController: controller];
    [self.contentContainerView addSubview: controller.view];
    self.currentContentViewController = controller;
    [controller.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    if ([content respondsToSelector:@selector(leftBarItem)]) {
        self.navigationItem.leftBarButtonItem = [content leftBarItem];
    }
    if ([content respondsToSelector:@selector(rightBarItem)]) {
        self.navigationItem.rightBarButtonItem = [content rightBarItem];
    }
    if ([content respondsToSelector:@selector(titleView)]) {
        self.navigationItem.titleView = [content titleView];
    }
    else {
        self.navigationItem.titleView = self.defaultTitleView;
        self.title = [controller title];
    }
    
    ModuleConfigurationPromise *promise = [[ModuleConfigurationPromise alloc] init];
    promise.moduleConfigurator = [content respondsToSelector:@selector(moduleConfigurator)] ? [content moduleConfigurator] : nil;
    return promise;
}

@end