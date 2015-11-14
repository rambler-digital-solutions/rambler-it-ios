//
//  RamblerLocationView.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RamblerLocationViewInput.h"

@protocol RamblerLocationViewOutput;

@interface RamblerLocationViewController : UIViewController<RamblerLocationViewInput>

@property (nonatomic, strong) id<RamblerLocationViewOutput> output;

@end

