//
// XCTestCase+CollectionViewDataDisplayManager.h
// LiveJournal
// 
// Created by Golovko Mikhail on 28/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (CollectionViewDataDisplayManager)

/**
 @author Golovko Mikhail
 
 Метод конфигурирует ячейку через dataSource.
 
 @param dataSource             DataSource табилцы
 @param mockCell               Ячейка, которая будет конфигурироваться
 @param originalCellIdentifier Идентификатор чейки
 @param testIndexPath          Индекс ячейки
 */
- (void)testCollectionViewViewDataSource:(id <UICollectionViewDataSource>)dataSource
                            withMockCell:(id)mockCell
                  originalCellIdentifier:(NSString *)originalCellIdentifier
                           testIndexPath:(NSIndexPath *)testIndexPath;

@end