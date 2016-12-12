// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MessagesViewController.h"

#import "MessageExtensionTyphoonActivator.h"
#import "EventPlainObject.h"
#import "DataDisplayManager.h"

static CGFloat const kiMessageEventTableViewEstimatedRowHeight = 100.0f;

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MessageExtensionTyphoonActivator activateWithSourceViewController:self];
}

#pragma mark - MessagesViewInput

- (void)setupViewWithNewMessage:(MSMessage *)message {
    [self.currentConversation insertMessage:message
                          completionHandler:nil];
}

#pragma mark - AnnouncementListViewInput

- (void)setupViewWithEventList:(NSArray *)events {
    self.dataDisplayManager.delegate = self;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = kiMessageEventTableViewEstimatedRowHeight;

    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView
                                                           withBaseDelegate:self];
    [self.dataDisplayManager updateTableViewModelWithEvents:events];
}

#pragma mark - EventListDataDisplayManagerDelegate

- (void)didTapCellWithEvent:(EventPlainObject *)event {
    [self.output didInsertNewMessageWithEvent:event];
}

#pragma mark - Conversation Handling

- (void)willBecomeActiveWithConversation:(MSConversation *)conversation {
    self.currentConversation = conversation;
    if (self.currentConversation.selectedMessage != nil) {
        [self.output didTapMessageWith:self.currentConversation.selectedMessage
                  withExtensionContext:self.extensionContext];
    } else {
        [self.output setupView];
    }
}

@end
