//
//  SignUpAndSaveToCalendarEventTableViewCellActionProtocol.h
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SignUpAndSaveToCalendarEventTableViewCellActionProtocol <NSObject>

- (void)didTapSignUpButton:(UIButton *)button;
- (void)didTapSaveToCalendarButton:(UIButton *)button;

@end
