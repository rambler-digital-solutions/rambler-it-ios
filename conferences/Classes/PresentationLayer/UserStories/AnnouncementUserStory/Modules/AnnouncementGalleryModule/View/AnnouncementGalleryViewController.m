//
//  AnnouncementGalleryAnnouncementGalleryViewController.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "AnnouncementGalleryViewController.h"

#import "AnnouncementGalleryViewOutput.h"

@implementation AnnouncementGalleryViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы AnnouncementGalleryViewInput

- (void)setupInitialState {
	// В этом методе происходит настройка параметров view, зависящих от ее жизненого цикла (создание элементов, анимации и пр.)
}

@end
