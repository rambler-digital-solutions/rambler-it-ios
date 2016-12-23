//
//  TVEventListModuleTVEventListModuleInteractorTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVEventListModuleInteractor.h"

#import "TVEventListModuleInteractorOutput.h"

@interface TVEventListModuleInteractorTests : XCTestCase

@property (nonatomic, strong) TVEventListModuleInteractor *interactor;

@property (nonatomic, strong) id mockOutput;

@end

@implementation TVEventListModuleInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[TVEventListModuleInteractor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(TVEventListModuleInteractorOutput));

    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов TVEventListModuleInteractorInput

@end
