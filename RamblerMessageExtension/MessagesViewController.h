//
//  MessagesViewController.h
//  RamblerMessageExtension
//
//  Created by Trishina Ekaterina on 13/09/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Messages/Messages.h>

@class EventListTableViewController;

@interface MessagesViewController : MSMessagesAppViewController

@property (nonatomic, strong) EventListTableViewController *childViewController;

@end
