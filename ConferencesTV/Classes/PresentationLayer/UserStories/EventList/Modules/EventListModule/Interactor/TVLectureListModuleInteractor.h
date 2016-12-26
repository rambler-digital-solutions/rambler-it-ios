//
//  TVLectureListModuleTVLectureListModuleInteractor.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TVLectureListModuleInteractorInput.h"

@protocol TVLectureListModuleInteractorOutput;

@interface TVLectureListModuleInteractor : NSObject <TVLectureListModuleInteractorInput>

@property (nonatomic, weak) id<TVLectureListModuleInteractorOutput> output;

@end
