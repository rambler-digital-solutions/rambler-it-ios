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

#import <MagicalRecord/MagicalRecord.h>
#import "EventService.h"
#import "ROSPonsomizer.h"
#import "EventPlainObject.h"
#import "DataDisplayManager.h"
#import "MessagesLaunchHandler.h"
#import "ObjectTransformer.h"
#import "MessagesConstants.h"
#import "EventListProcessor.h"

static CGFloat const kiMessageEventTableViewEstimatedRowHeight = 100.0f;

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MessageExtensionTyphoonActivator activateWithSourceViewController:self];
}

#pragma mark - setups

- (void)setupCoreData {
    NSURL *directory = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:RCFAppGroupIdentifier];
    NSURL *storeURL = [directory  URLByAppendingPathComponent:RCFCoreDataNameKey];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:storeURL];
}

- (void)loadEvents {
    NSArray *events = [self.eventService obtainEventsWithPredicate:nil];
    NSArray *plainObjects = [self.ponsomizer convertObject:events];
    NSArray *sortedEvents = [EventListProcessor sortEventsByDate:plainObjects];
    [self setupViewWithEventList:sortedEvents];
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
    NSString *identifier = [self.transformer identifierForObject:event];
    MSMessage *message = [MSMessage new];
    MSMessageTemplateLayout *layout = [MSMessageTemplateLayout new];
    layout.caption = event.name;
    layout.subcaption = event.eventSubtitle;
    layout.mediaFileURL = [NSURL URLWithString:event.imageUrl];
    message.layout = layout;
    message.URL = [NSURL URLWithString:identifier];
    MSConversation *conversation = [MSConversation new];
    [conversation insertMessage:message completionHandler:nil];
}

#pragma mark - Conversation Handling

- (void)willBecomeActiveWithConversation:(MSConversation *)conversation {
    MSConversation *savedConversation = conversation;
    if (savedConversation.selectedMessage != nil) {
        NSString *identifier = savedConversation.selectedMessage.URL.absoluteString;
        if ([self.transformer isCorrectIdentifier:identifier]) {
            [self openURLWithIdentifier:identifier];
        }
    } else {
        [self setupCoreData];
        [self loadEvents];
    }
}

- (void)openURLWithIdentifier:(NSString *)identifier {
    NSURLComponents *urlComponents = [NSURLComponents new];
    urlComponents.scheme = RCFURLScheme;
    urlComponents.host = RCFURLHostName;
    NSArray *identifierArray = [identifier componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"_"]];
    NSURLQueryItem *type = [NSURLQueryItem queryItemWithName:RCFURLQueryItemType
                                                       value:[identifierArray firstObject]];
    NSURLQueryItem *itemId = [NSURLQueryItem queryItemWithName:RCFURLQueryItemId
                                                         value:identifier];

    urlComponents.queryItems = @[type, itemId];

    [self.extensionContext openURL:urlComponents.URL
            completionHandler:nil];
}

@end
