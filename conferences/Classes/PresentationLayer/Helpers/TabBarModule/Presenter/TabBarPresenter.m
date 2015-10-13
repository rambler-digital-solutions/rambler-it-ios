
#import "TabBarPresenter.h"
#import "TabBarViewInput.h"
#import "TabBarInteractorInput.h"
#import "TabBarRouterInput.h"

@interface TabBarPresenter()

@end

@implementation TabBarPresenter

#pragma mark - RootModuleConfigurator

- (void)configureModule {

}

#pragma mark - RootViewOutput

- (void)setupView {
    [self.interactor getTabs];
}
- (void)selectedTabWithIndex:(NSUInteger)tabIndex {
    [self.router openTabWithIndex:tabIndex];
}

#pragma mark - RootInteractorOutput

- (void)showTabs:(NSArray*)tabs {
    [self.view showTabs:tabs];
    [self.router openTabWithIndex:0];
}

@end