//
//  RDSCollectionViewDataDisplayManager.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 15/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RDSCollectionViewSupplementaryViewObjectProtocol;

@interface RDSCollectionViewDataDisplayManager : NSObject<UICollectionViewDataSource>

- (instancetype)initWithHeaderObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)headerObject
                        footerObject:(id<RDSCollectionViewSupplementaryViewObjectProtocol>)footerObject
              andFlatListCellObjects:(NSArray*)cellObjects;

- (instancetype)initWithFlatListCellObjects:(NSArray*)cellObjects;

- (CGSize)sizeForHeaderInSection:(NSUInteger)section inCollectionView:(UICollectionView*)collectionView;
- (CGSize)sizeForFooterInSection:(NSUInteger)section inCollectionView:(UICollectionView*)collectionView;

@property (nonatomic,strong) NSString* cellReuseId;

@end
