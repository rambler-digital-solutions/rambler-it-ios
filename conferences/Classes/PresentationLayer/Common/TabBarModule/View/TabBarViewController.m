
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