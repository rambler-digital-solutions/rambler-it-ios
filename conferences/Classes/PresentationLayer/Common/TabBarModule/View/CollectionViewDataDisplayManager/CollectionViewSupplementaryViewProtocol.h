
#import <Foundation/Foundation.h>

@protocol CollectionViewSupplementaryViewProtocol <NSObject>

- (void)configureWithObject:(id)object;

@optional

+(CGSize)sizeForObject:(id)object inCollectionView:(UICollectionView*)collectionView;

@end
