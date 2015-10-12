//
//  RDSCollectionViewDataDisplayManager.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 15/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSCollectionViewDataDisplayManager.h"
#import "RDSCollectionViewSupplementaryViewProtocol.h"
#import "RDSCollectionViewSupplementaryViewObjectProtocol.h"
#import "RDSCollectionViewSectionInfo.h"
#import "RDSCollectionViewCellObjectProtocol.h"
#import "RDSCollectionViewCellProtocol.h"

static NSCache *reusableViewsCache;

@interface RDSCollectionViewDataDisplayManager ()

@property (nonatomic,strong) NSArray *sections;

@end

@implementation RDSCollectionViewDataDisplayManager

- (instancetype)initWithHeaderObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)footerObject
              andFlatListCellObjects:(NSArray*)cellObjects {
    
    self = [super init];
    if (self) {
        
        RDSCollectionViewSectionInfo *sectionInfo = [[RDSCollectionViewSectionInfo alloc] initWithHeaderObject:headerObject
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
    
    RDSCollectionViewSectionInfo *sectionInfo = self.sections[indexPath.section];
    
    id<RDSCollectionViewSupplementaryViewObjectProtocol> collectionViewObject = nil;
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
            [(id<RDSCollectionViewSupplementaryViewProtocol>)supplementaryView configureWithObject:collectionViewObject];
        }
        result = supplementaryView;
    }
    
    return result;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    RDSCollectionViewSectionInfo *sectionInfo = self.sections[section];
    return sectionInfo.cellObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *result = nil;
    
    RDSCollectionViewSectionInfo *sectionInfo = self.sections[indexPath.section];
    id<RDSCollectionViewCellObjectProtocol> cellObject  = sectionInfo.cellObjects[indexPath.item];

    NSString *cellReuseId = self.cellReuseId;
    if (cellReuseId == nil && [cellObject respondsToSelector:@selector(cellReuseId)]) {
        cellReuseId = [cellObject cellReuseId];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseId
                                                                           forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configureWithObject:)]) {
        [(id<RDSCollectionViewCellProtocol>)cell configureWithObject:cellObject];
    }
    result = cell;

    return result;
    
}

- (UICollectionReusableView<RDSCollectionViewSupplementaryViewProtocol> *)tryLoadNibForViewWithClass:(Class)viewClass {
    
    UICollectionReusableView<RDSCollectionViewSupplementaryViewProtocol> *view = [[UINib nibWithNibName:NSStringFromClass(viewClass) bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    
    if ([view isKindOfClass:[UICollectionReusableView class]] && [view conformsToProtocol:@protocol(RDSCollectionViewSupplementaryViewProtocol)]) {
        [reusableViewsCache setObject:view forKey:viewClass];
        return view;
    }
    else {
        return nil;
    }
}

- (CGSize)sizeDeterminedByConstraintsForViewWithClass:(Class)viewClass
                             withCollectionViewObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)collectionViewObject
                                     inCollectionView:(UICollectionView*)collectionView {
    
    CGSize size = CGSizeMake(0, 0);
    
    NSString *className = NSStringFromClass(viewClass);
    UICollectionReusableView<RDSCollectionViewSupplementaryViewProtocol> *view = [reusableViewsCache objectForKey:className];
    
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
    RDSCollectionViewSectionInfo *sectionInfo = self.sections[section];
    
    id<RDSCollectionViewSupplementaryViewObjectProtocol> collectionViewObject = sectionInfo.headerObject;
    
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
    
    RDSCollectionViewSectionInfo *sectionInfo = self.sections[section];
    
    id<RDSCollectionViewSupplementaryViewObjectProtocol> collectionViewObject = sectionInfo.footerObject;
    
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
