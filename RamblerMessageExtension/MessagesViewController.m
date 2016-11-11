//
//  MessagesViewController.m
//  RamblerMessageExtension
//
//  Created by Trishina Ekaterina on 13/09/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "MessagesViewController.h"

// Ассембли
#import "EventListModuleAssembly.h"
#import "MessageExtensionAssembly.h"
#import "PonsomizerAssembly.h"
#import "PresentationLayerHelpersAssembly.h"
#import "ServiceComponentsAssembly.h"
#import "SpotlightIndexerAssembly.h"

#import <MagicalRecord/MagicalRecord.h>

#import "EventService.h"

#import "ROSPonsomizer.h"

#import "EventPlainObject.h"
#import "DataDisplayManager.h"

#import "MessagesLaunchHandler.h"

#import "ObjectTransformer.h"

#import "MessagesConstants.h"


static CGFloat const kiMessageEventTableViewEstimatedRowHeight = 100.0f;

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self activateTyphoon];
}

#pragma mark - setups

- (void)activateTyphoon {
    TyphoonComponentFactory *factory = [TyphoonBlockComponentFactory factoryWithAssemblies:@[[MessageExtensionAssembly assembly], [EventListModuleAssembly assembly], [PonsomizerAssembly assembly], [ServiceComponentsAssembly assembly], [PresentationLayerHelpersAssembly assembly], [SpotlightIndexerAssembly assembly]]];
    [factory makeDefault];
    [factory inject:self];
}

- (void)setupCoreData {
    NSURL *directory = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:RCFAppGroupIdentifier];
    NSURL *storeURL = [directory  URLByAppendingPathComponent:RCFCoreDataNameKey];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:storeURL];
}

- (void)loadEvents {
    NSArray *events = [self.eventService obtainEventsWithPredicate:nil];
    NSArray *plainObjects = [self.ponsomizer convertObject:events];
    NSArray *sortedEvents = [self sortEventsByDate:plainObjects];
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

#pragma mark - Private methods

- (NSArray *)sortEventsByDate:(NSArray *)events {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(startDate)) ascending:NO];
    events = [[events sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];

    return events;
}

@end
