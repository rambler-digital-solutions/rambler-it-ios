
#import <UIKit/UIKit.h>

@protocol CollectionViewSupplementaryViewObjectProtocol;

@interface CollectionViewDataDisplayManager : NSObject<UICollectionViewDataSource>

- (instancetype)initWithHeaderObject:(id<CollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<CollectionViewSupplementaryViewObjectProtocol>)footerObject
              andFlatListCellObjects:(NSArray*)cellObjects;

- (instancetype)initWithFlatListCellObjects:(NSArray*)cellObjects;

- (CGSize)sizeForHeaderInSection:(NSUInteger)section inCollectionView:(UICollectionView*)collectionView;
- (CGSize)sizeForFooterInSection:(NSUInteger)section inCollectionView:(UICollectionView*)collectionView;

@property (nonatomic,strong) NSString* cellReuseId;

@end
