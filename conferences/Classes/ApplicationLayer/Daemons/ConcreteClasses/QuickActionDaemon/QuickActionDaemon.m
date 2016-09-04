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

#import "QuickActionDaemon.h"

#import "EventModelObject.h"

#import <MagicalRecord/MagicalRecord.h>
#import <UIKit/UIKit.h>

static NSString *const RCFManagedObjectContextNotificationKey = @"managedObjectContext";

@interface QuickActionDaemon ()

@property (nonatomic, strong) UIApplication *application;
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;

@end

@implementation QuickActionDaemon

#pragma mark - Initialization

- (instancetype)initWithApplication:(UIApplication *)application
                 notificationCenter:(NSNotificationCenter *)notificationCenter {
    self = [super init];
    if (self) {
        _application = application;
        _notificationCenter = notificationCenter;
    }
    return self;
}

#pragma mark - <Daemon>

- (void)start {
    [self.notificationCenter addObserver:self
                                selector:@selector(handleObjectsWillChangeNotification:)
                                    name:NSManagedObjectContextObjectsDidChangeNotification
                                  object:nil];
}

- (void)stop {
    [self.notificationCenter removeObserver:self];
}

#pragma mark - Private methods

- (void)handleObjectsWillChangeNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];

    NSArray *updatedObjects = userInfo[NSUpdatedObjectsKey];
    for (NSManagedObject *object in updatedObjects) {
        if ([object isKindOfClass:[EventModelObject class]]) {
            [self handleUpdatedEvent:object];
        }
    }
}

- (void)handleUpdatedEvent:(NSManagedObject *)event {
    NSDictionary *changedValues = event.changedValues;
    if (changedValues[EventModelObjectAttributes.lastVisitDate] != nil) {
        if ([NSThread isMainThread]) {
            [self registerDynamicActionWithEvent:(EventModelObject *)event];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self registerDynamicActionWithEvent:(EventModelObject *)event];
            });
        }
    }
}

- (void)registerDynamicActionWithEvent:(EventModelObject *)event {
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"myTYpe" localizedTitle:@"test" localizedSubtitle:@"test" icon:nil userInfo:nil];
    self.application.shortcutItems = @[item];
}

@end
