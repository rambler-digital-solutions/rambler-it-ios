
#import <Foundation/Foundation.h>
#import "TabBarInteractorInput.h"

@class TabsDDM;
@protocol TabBarInteractorOutput;

@interface TabBarInteractor : NSObject <TabBarInteractorInput>

@property (nonatomic,strong) NSArray *tabs;
@property (nonatomic, weak) id<TabBarInteractorOutput> output;

@end

