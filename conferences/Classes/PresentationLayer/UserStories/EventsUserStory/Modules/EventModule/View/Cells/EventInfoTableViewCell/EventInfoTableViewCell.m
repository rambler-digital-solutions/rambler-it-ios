//
//  EventInfoTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 07/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventInfoTableViewCell.h"
#import "EventInfoTableViewCellObject.h"
#import "EventTableViewCellActionProtocol.h"
#import "EventInfoTableViewCellActionProtocol.h"
#import "Proxying/Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"

static CGFloat const EventInfoTableViewCellHeight = 520.0f;

@interface EventInfoTableViewCell ()

 //eventSubTitle ограничить количество символов?

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventSubTitle;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;

@property (weak, nonatomic) id <EventInfoTableViewCellActionProtocol> actionProxy;

@end

@implementation EventInfoTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<EventInfoTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

- (BOOL)shouldUpdateCellWithObject:(EventInfoTableViewCellObject *)object {
    self.date.text = object.date;
    self.eventTitle.text = object.eventTitle;
    self.eventSubTitle.text = object.eventSubTitle;
    self.eventDescription.text = object.eventDescription;
    
    return  YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return EventInfoTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapSignUpButton:(UIButton *)sender {
    [self.actionProxy didTapSignUpButton:sender];
}

- (IBAction)didTapSaveToCalendarButton:(UIButton *)sender {
    [self.actionProxy didTapSaveToCalendarButton:sender];
}

- (IBAction)didTapReadMoreButton:(UIButton *)sender {
    [self.actionProxy didTapReadMoreEventDescriptionButton:sender];
}

@end
