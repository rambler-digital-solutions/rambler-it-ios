//
//  ChainableOperationTestsBase.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

@protocol ChainableOperation;

/**
 @author Egor Tolstoy
 
 Базовый класс для тестов под-операций
 */
@interface ChainableOperationTestsBase : XCTestCase

/**
 @author Egor Tolstoy
 
 Метод настраивает входные данные для операции
 */
- (void)setInputData:(id)data
        forOperation:(NSOperation <ChainableOperation> *)operation;

/**
 @author Egor Tolstoy
 
 Метод настраивает выходные данные для операции
 */
- (void)setOutputData:(id)data
         forOperation:(NSOperation <ChainableOperation> *)operation;

/**
 @author Egor Tolstoy
 
 Метод проверяет output у переданной ему операции
 
 @param operation Операция
 */
- (void)verifyNotNilResultForOperation:(NSOperation <ChainableOperation> *)operation;

@end
