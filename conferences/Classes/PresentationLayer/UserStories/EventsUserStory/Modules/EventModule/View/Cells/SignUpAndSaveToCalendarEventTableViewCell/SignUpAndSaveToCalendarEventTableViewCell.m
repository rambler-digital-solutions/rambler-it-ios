//
//  EventInteractionTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "SignUpAndSaveToCalendarEventTableViewCell.h"
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"
#import "SignUpAndSaveToCalendarEventTableViewCellActionProtocol.h"
#import "EventTableViewCellActionProtocol.h"
#import "Proxying/Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"

static CGFloat const kSignUpAndSaveToCalendarEventTableViewCellHeight = 120.0f;

@interface SignUpAndSaveToCalendarEventTableViewCell ()

@property (weak, nonatomic) id <SignUpAndSaveToCalendarEventTableViewCellActionProtocol> actionProxy;

@end

@implementation SignUpAndSaveToCalendarEventTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<SignUpAndSaveToCalendarEventTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(SignUpAndSaveToCalendarEventTableViewCellObject *)object {
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kSignUpAndSaveToCalendarEventTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapSignUpButton:(UIButton *)sender {
    [self.actionProxy didTapSignUpButton:sender];
}

- (IBAction)didTapSaveToCalendarButton:(UIButton *)sender {
    [self.actionProxy didTapSaveToCalendarButton:sender];
}

@end
