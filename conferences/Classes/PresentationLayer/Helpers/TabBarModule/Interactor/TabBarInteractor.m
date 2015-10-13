
#import "TabBarInteractor.h"
#import "TabBarInteractorOutput.h"

@interface TabBarInteractor()

@end

@implementation TabBarInteractor

#pragma mark - RootInteractorInput

- (void)getTabs {
    [self.output showTabs:self.tabs];
}

@end