//
// TagCollectionView.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagDataDisplayManager.h"
#import "TagViewInput.h"
#import "TagModuleInput.h"

@class TagDataDisplayManager;
@protocol TagViewOutput;
@class TagCellSizeConfig;


@interface TagCollectionView : UICollectionView <TagViewInput, TagDataDisplayManagerDelegate, TagModuleInput>

+ (TagCollectionView *)collectionView;

@property (nonatomic, strong) id<TagModuleInput> moduleInput;
@property (nonatomic, strong) id<TagViewOutput> output;
@property (nonatomic, strong) TagDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) TagCellSizeConfig *cellSizeConfig;

@end