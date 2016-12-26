//
//  TVLectureListModuleTVLectureListModuleViewController.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVLectureListModuleViewController.h"

#import "TVLectureListModuleViewOutput.h"

@implementation TVLectureListModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы TVLectureListModuleViewInput

- (void)setupInitialState {
	// В этом методе происходит настройка параметров view, зависящих от ее жизненого цикла (создание элементов, анимации и пр.)
}

- (void)updateLectureListWithLectures:(NSArray *)lectures {
    
}

@end
