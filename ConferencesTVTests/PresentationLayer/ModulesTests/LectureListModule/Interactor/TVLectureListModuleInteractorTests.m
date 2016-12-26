//
//  TVLectureListModuleTVLectureListModuleInteractorTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVLectureListModuleInteractor.h"

#import "TVLectureListModuleInteractorOutput.h"

@interface TVLectureListModuleInteractorTests : XCTestCase

@property (nonatomic, strong) TVLectureListModuleInteractor *interactor;

@property (nonatomic, strong) id mockOutput;

@end

@implementation TVLectureListModuleInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[TVLectureListModuleInteractor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(TVLectureListModuleInteractorOutput));

    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов TVLectureListModuleInteractorInput

@end
