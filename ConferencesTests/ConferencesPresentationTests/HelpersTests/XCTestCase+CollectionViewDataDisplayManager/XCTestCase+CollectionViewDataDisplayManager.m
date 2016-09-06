//
// XCTestCase+CollectionViewDataDisplayManager.m
// LiveJournal
// 
// Created by Golovko Mikhail on 28/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "XCTestCase+CollectionViewDataDisplayManager.h"
#import "MockObjectsFactory.h"


@implementation XCTestCase (CollectionViewDataDisplayManager)
- (void)testCollectionViewViewDataSource:(id <UICollectionViewDataSource>)dataSource
                            withMockCell:(id)mockCell
                  originalCellIdentifier:(NSString *)originalCellIdentifier
                           testIndexPath:(NSIndexPath *)testIndexPath {
    UICollectionView *mockCollectionView = [MockObjectsFactory mockCollectionViewViewWithMockCell:mockCell
                                                                                    forIdentifier:originalCellIdentifier];
    mockCollectionView.dataSource = dataSource;

    [dataSource collectionView:mockCollectionView
        cellForItemAtIndexPath:testIndexPath];
}

@end