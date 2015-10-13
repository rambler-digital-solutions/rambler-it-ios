
#import <Foundation/Foundation.h>
#import "TabBarViewOutput.h"
#import "TabBarInteractorOutput.h"
#import "TabBarModuleConfigurator.h"

@protocol TabBarViewInput;
@protocol TabBarInteractorInput;
@protocol TabBarRouterInput;

@interface TabBarPresenter : NSObject <TabBarViewOutput, TabBarInteractorOutput, TabBarModuleConfigurator>

@property (nonatomic, weak) id<TabBarViewInput> view;
@property (nonatomic, strong) id<TabBarInteractorInput> interactor;
@property (nonatomic, strong) id<TabBarRouterInput> router;

@end

