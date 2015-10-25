
#import <UIKit/UIKit.h>
#import "TabBarViewInput.h"
#import "TabBarControllerContentEmbedder.h"

@protocol TabBarViewOutput;

@interface TabBarViewController : UIViewController <TabBarViewInput,TabBarControllerContentEmbedder>

@property (nonatomic, strong) id<TabBarViewOutput> output;

@property (nonatomic, weak) IBOutlet UICollectionView *tabButtonsCollectionView;
@property (nonatomic, weak) IBOutlet UIView *contentContainerView;

@end

