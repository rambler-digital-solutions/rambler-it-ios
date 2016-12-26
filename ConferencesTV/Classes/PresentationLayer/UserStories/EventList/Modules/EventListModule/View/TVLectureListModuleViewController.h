//
//  TVLectureListModuleTVLectureListModuleViewController.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TVLectureListModuleViewInput.h"

@protocol TVLectureListModuleViewOutput;

@interface TVLectureListModuleViewController : UIViewController <TVLectureListModuleViewInput>

@property (nonatomic, strong) id<TVLectureListModuleViewOutput> output;

@end
