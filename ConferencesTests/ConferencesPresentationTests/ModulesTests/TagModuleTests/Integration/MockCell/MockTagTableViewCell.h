//
// MockTagTableViewCell.h
// LiveJournal
// 
// Created by Golovko Mikhail on 28/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagModuleTableViewCell.h"


@interface MockTagTableViewCell : TagModuleTableViewCell

@property (nonatomic, strong) id mockTagCollectionView;
@property (nonatomic, strong) id mockSizeObserver;

@end