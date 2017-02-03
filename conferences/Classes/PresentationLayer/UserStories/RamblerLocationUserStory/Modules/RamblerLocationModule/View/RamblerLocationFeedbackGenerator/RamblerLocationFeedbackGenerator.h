//
//  RamblerLocationFeedbackGenerator.h
//  Conferences
//
//  Created by s.sarkisyan on 03.02.17.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIScrollView;

/**
 @author Surik Sarkisyan
 
 Feedbacks(taptic engine) generator
 */
@protocol RamblerLocationFeedbackGenerator <NSObject>

/**
 @author Surik Sarkisyan
 
 Method is used to generate selection feedback when scroll page did change via UISelectionFeedbackGenerator
 */
- (void)generateSelectionFeedbackInScrollView:(UIScrollView *)scrollView;

@end
