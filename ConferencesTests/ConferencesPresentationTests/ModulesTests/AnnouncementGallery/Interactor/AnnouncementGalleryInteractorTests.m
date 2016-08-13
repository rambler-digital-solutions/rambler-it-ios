//
//  AnnouncementGalleryAnnouncementGalleryInteractorTests.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AnnouncementGalleryInteractor.h"

#import "AnnouncementGalleryInteractorOutput.h"

@interface AnnouncementGalleryInteractorTests : XCTestCase

@property (nonatomic, strong) AnnouncementGalleryInteractor *interactor;

@property (nonatomic, strong) id mockOutput;

@end

@implementation AnnouncementGalleryInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[AnnouncementGalleryInteractor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(AnnouncementGalleryInteractorOutput));

    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов AnnouncementGalleryInteractorInput

@end
