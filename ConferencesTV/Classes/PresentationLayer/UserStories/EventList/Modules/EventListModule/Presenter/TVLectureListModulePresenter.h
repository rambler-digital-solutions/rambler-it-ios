//
//  TVLectureListModuleTVLectureListModulePresenter.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVLectureListModuleViewOutput.h"
#import "TVLectureListModuleInteractorOutput.h"
#import "TVLectureListModuleModuleInput.h"

@protocol TVLectureListModuleViewInput;
@protocol TVLectureListModuleInteractorInput;
@protocol TVLectureListModuleRouterInput;

@interface TVLectureListModulePresenter : NSObject <TVLectureListModuleModuleInput, TVLectureListModuleViewOutput, TVLectureListModuleInteractorOutput>

@property (nonatomic, weak) id<TVLectureListModuleViewInput> view;
@property (nonatomic, strong) id<TVLectureListModuleInteractorInput> interactor;
@property (nonatomic, strong) id<TVLectureListModuleRouterInput> router;

@end
