//
//  SpeakerInfoView.h
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeakerInfoViewInput.h"

@protocol SpeakerInfoViewOutput;
@class SpeakerInfoDataDisplayManager;

@interface SpeakerInfoViewController : UIViewController <SpeakerInfoViewInput>

@property (strong, nonatomic) id <SpeakerInfoViewOutput> output;
@property (strong, nonatomic) SpeakerInfoDataDisplayManager *dataDisplayManager;

@end

