//
//  TVEventListModuleTVEventListModuleViewController.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TVEventListModuleViewInput.h"

@protocol TVEventListModuleViewOutput;

@interface TVEventListModuleViewController : UIViewController <TVEventListModuleViewInput>

@property (nonatomic, strong) id<TVEventListModuleViewOutput> output;

@end
