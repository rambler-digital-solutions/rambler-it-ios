//
// MockTagTableViewCell.m
// LiveJournal
// 
// Created by Golovko Mikhail on 28/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "MockTagTableViewCell.h"
#import <OCMock/OCMock.h>
#import "TagCollectionView.h"
#import "ContentSizeObserver.h"

@implementation MockTagTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {

        _mockTagCollectionView = OCMClassMock([TagCollectionView class]);
        self.tagCollectionView = _mockTagCollectionView;

        _mockSizeObserver = OCMClassMock([ContentSizeObserver class]);
        self.sizeObserver = _mockSizeObserver;
    }
    return self;
}

- (void)dealloc {
    [self.mockTagCollectionView stopMocking];
    [self.mockSizeObserver stopMocking];
}

@end