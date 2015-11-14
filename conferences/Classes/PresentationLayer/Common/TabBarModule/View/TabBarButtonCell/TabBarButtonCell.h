
#import <UIKit/UIKit.h>
#import "CollectionViewCellProtocol.h"

@interface TabBarButtonCell : UICollectionViewCell<CollectionViewCellProtocol>

@property (nonatomic,strong) UIColor *selectionTint;
@property (nonatomic,strong) UIColor *idleTint;

@property (nonatomic,weak) IBOutlet UIImageView *tabIcon;
@property (nonatomic,weak) IBOutlet UILabel *tabLabel;

@end
