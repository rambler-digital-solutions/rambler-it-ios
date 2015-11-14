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

static CGFloat const EventInfoTableViewCellHeight = 150.0f;

@interface EventInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventSubTitle;

@property (weak, nonatomic) id <EventInfoTableViewCellActionProtocol> actionProxy;

@end

@implementation EventInfoTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<EventInfoTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(EventInfoTableViewCellObject *)object {
    self.date.text = object.date;
    self.eventTitle.text = object.eventTitle;
    self.eventSubTitle.text = object.eventSubTitle;
    
    return  YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return EventInfoTableViewCellHeight;
}

@end
