
#import "CollectionViewDataDisplayManager.h"
#import "CollectionViewSupplementaryViewProtocol.h"
#import "CollectionViewSupplementaryViewObjectProtocol.h"
#import "CollectionViewSectionInfo.h"
#import "CollectionViewCellObjectProtocol.h"
#import "CollectionViewCellProtocol.h"

static NSCache *reusableViewsCache;

@interface CollectionViewDataDisplayManager ()

@property (nonatomic,strong) NSArray *sections;

@end

@implementation CollectionViewDataDisplayManager

- (instancetype)initWithHeaderObject:(id<CollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<CollectionViewSupplementaryViewObjectProtocol>)footerObject
              andFlatListCellObjects:(NSArray*)cellObjects {
    
    self = [super init];
    if (self) {
        
        CollectionViewSectionInfo *sectionInfo = [[CollectionViewSectionInfo alloc] initWithHeaderObject:headerObject
                                                                                                footerObject:footerObject
                                                                                      andFlatListCellObjects:cellObjects];
        self.sections = @[ sectionInfo ];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            reusableViewsCache = [[NSCache alloc] init];
        });

    }
    return self;
}

- (instancetype)initWithFlatListCellObjects:(NSArray*)cellObjects {
    return [self initWithHeaderObject:nil footerObject:nil andFlatListCellObjects:cellObjects];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *result = nil;
    
    CollectionViewSectionInfo *sectionInfo = self.sections[indexPath.section];
    
    id<CollectionViewSupplementaryViewObjectProtocol> collectionViewObject = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        collectionViewObject = sectionInfo.headerObject;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        collectionViewObject = sectionInfo.footerObject;
    }
    
    if ([collectionViewObject respondsToSelector:@selector(supplementaryViewReuseId)]) {
        
        NSString *supplementaryViewReuseId = [collectionViewObject supplementaryViewReuseId];
        UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                         withReuseIdentifier:supplementaryViewReuseId
                                                                                                forIndexPath:indexPath];
        if ([supplementaryView respondsToSelector:@selector(configureWithObject:)]) {
            [(id<CollectionViewSupplementaryViewProtocol>)supplementaryView configureWithObject:collectionViewObject];
        }
        result = supplementaryView;
    }
    
    return result;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CollectionViewSectionInfo *sectionInfo = self.sections[section];
    return sectionInfo.cellObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *result = nil;
    
    CollectionViewSectionInfo *sectionInfo = self.sections[indexPath.section];
    id<CollectionViewCellObjectProtocol> cellObject  = sectionInfo.cellObjects[indexPath.item];

    NSString *cellReuseId = self.cellReuseId;
    if (cellReuseId == nil && [cellObject respondsToSelector:@selector(cellReuseId)]) {
        cellReuseId = [cellObject cellReuseId];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseId
                                                                           forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configureWithObject:)]) {
        [(id<CollectionViewCellProtocol>)cell configureWithObject:cellObject];
    }
    result = cell;

    return result;
    
}

- (UICollectionReusableView<CollectionViewSupplementaryViewProtocol> *)tryLoadNibForViewWithClass:(Class)viewClass {
    
    UICollectionReusableView<CollectionViewSupplementaryViewProtocol> *view = [[UINib nibWithNibName:NSStringFromClass(viewClass) bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    
    if ([view isKindOfClass:[UICollectionReusableView class]] && [view conformsToProtocol:@protocol(CollectionViewSupplementaryViewProtocol)]) {
        [reusableViewsCache setObject:view forKey:viewClass];
        return view;
    }
    else {
        return nil;
    }
}

- (CGSize)sizeDeterminedByConstraintsForViewWithClass:(Class)viewClass
                             withCollectionViewObject:(id<CollectionViewSupplementaryViewObjectProtocol>)collectionViewObject
                                     inCollectionView:(UICollectionView*)collectionView {
    
    CGSize size = CGSizeMake(0, 0);
    
    NSString *className = NSStringFromClass(viewClass);
    UICollectionReusableView<CollectionViewSupplementaryViewProtocol> *view = [reusableViewsCache objectForKey:className];
    
    if (view == nil) {
        view = [self tryLoadNibForViewWithClass:viewClass];
    }
    
    if (view != nil) {
        view.frame = CGRectMake(0, 0, CGRectGetWidth(collectionView.bounds), CGRectGetHeight(collectionView.bounds));
        
        [view configureWithObject:collectionViewObject];
        
        [view setNeedsUpdateConstraints];
        [view updateConstraintsIfNeeded];
        
        [view setNeedsLayout];
        [view layoutIfNeeded];
        
        size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    }
    
    return size;
}

- (CGSize)sizeForHeaderInSection:(NSUInteger)section inCollectionView:(UICollectionView*)collectionView {
    CollectionViewSectionInfo *sectionInfo = self.sections[section];
    
    id<CollectionViewSupplementaryViewObjectProtocol> collectionViewObject = sectionInfo.headerObject;
    
    CGSize size = CGSizeMake(0, 0);
    
    if ([collectionViewObject respondsToSelector:@selector(supplementaryViewReuseId)]) {
        Class viewClass = [collectionViewObject supplementaryViewClass];
        if ([viewClass respondsToSelector:@selector(sizeForObject:inCollectionView:)]) {
            size = [viewClass sizeForObject: collectionViewObject inCollectionView:collectionView];
        }
        else {
            size = [self sizeDeterminedByConstraintsForViewWithClass:viewClass withCollectionViewObject:collectionViewObject inCollectionView:collectionView];
        }
    }

    return size;
}

- (CGSize)sizeForFooterInSection:(NSUInteger)section inCollectionView:(UICollectionView*)collectionView {
    
    CollectionViewSectionInfo *sectionInfo = self.sections[section];
    
    id<CollectionViewSupplementaryViewObjectProtocol> collectionViewObject = sectionInfo.footerObject;
    
    CGSize size = CGSizeMake(0, 0);
    
    if ([collectionViewObject respondsToSelector:@selector(supplementaryViewReuseId)]) {
        Class viewClass = [collectionViewObject supplementaryViewClass];
        if ([viewClass respondsToSelector:@selector(sizeForObject:inCollectionView:)]) {
            size = [viewClass sizeForObject: collectionViewObject inCollectionView:collectionView];
        }
        else {
            size = [self sizeDeterminedByConstraintsForViewWithClass:viewClass withCollectionViewObject:collectionViewObject inCollectionView:collectionView];
        }
    }

    return size;
}

@end
