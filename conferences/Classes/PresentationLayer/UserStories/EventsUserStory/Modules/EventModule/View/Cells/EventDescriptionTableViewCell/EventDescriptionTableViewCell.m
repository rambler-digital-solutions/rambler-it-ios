//
//  EventDescriptionTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventDescriptionTableViewCell.h"
#import "EventDescriptionTableViewCellObject.h"
#import "EventTableViewCellActionProtocol.h"
#import "EventDescriptionTableViewCellActionProtocol.h"
#import "Proxying/Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"

static CGFloat const kEventDescriptionTableViewCellHeight = 190.0f;

@interface EventDescriptionTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *eventDescription;

@property (weak, nonatomic) id <EventDescriptionTableViewCellActionProtocol> actionProxy;

@end

@implementation EventDescriptionTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<EventDescriptionTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(EventDescriptionTableViewCellObject *)object {
    self.eventDescription.text = object.eventDescription;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kEventDescriptionTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapReadMoreButton:(UIButton *)sender {
    [self.actionProxy didTapReadMoreEventDescriptionButton:sender];
}

@end
