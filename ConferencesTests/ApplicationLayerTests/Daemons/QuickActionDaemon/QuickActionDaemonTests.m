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

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <UIKit/UIKit.h>
#import <MagicalRecord/MagicalRecord.h>

#import "XCTestCase+RCFHelpers.h"
#import "EventModelObject.h"
#import "LectureModelObject.h"
#import "QuickActionMockApplication.h"

#import "QuickActionDaemon.h"

@interface QuickActionDaemonTests : XCTestCase

@property (nonatomic, strong) QuickActionDaemon *daemon;

@property (nonatomic, strong) QuickActionMockApplication *mockApplication;
@property (nonatomic, strong) id mockBundle;

@end

@implementation QuickActionDaemonTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.mockApplication = [QuickActionMockApplication new];
    self.mockBundle = OCMClassMock([NSBundle class]);
    
    self.daemon = [[QuickActionDaemon alloc] initWithApplication:(UIApplication *)self.mockApplication
                                              notificationCenter:[NSNotificationCenter defaultCenter]
                                                          bundle:self.mockBundle];
}

- (void)tearDown {
    self.daemon = nil;
 
    [self.mockBundle stopMocking];
    self.mockBundle = nil;
    
    [self tearDownCoreDataStack];
    [super tearDown];
}

- (void)testThatDaemonRegistersDynamicActionForVisitedEvent {
    // given
    EventModelObject *event = [self generateEventForTestPurposes];
    
    [self.daemon start];
    
    // when
    [self propagateVisitChangeForEvent:event];
    
    // then
    XCTAssertEqual(self.mockApplication.shortcutItems.count, 1);
}

- (void)testThatDaemonKeepsDeterminedNumberOfDynamicActions {
    // given
    NSUInteger maximumItemCount = 2;
    NSArray *shortcutItems = [self generateShortcutItemsWithCount:maximumItemCount];
    self.mockApplication.shortcutItems = shortcutItems;
    
    EventModelObject *event = [self generateEventForTestPurposes];
    
    [self.daemon start];
    
    // when
    [self propagateVisitChangeForEvent:event];
    
    // then
    XCTAssertEqual(self.mockApplication.shortcutItems.count, maximumItemCount);
}

- (void)testThatDaemonDoesNotIndexSameItemTwice {
    // given
    NSString *const kTestName = @"abcd";
    UIApplicationShortcutItem *firstItem = [self generateShortcutItemWithName:kTestName];
    self.mockApplication.shortcutItems = @[firstItem];
    
    EventModelObject *event = [self generateEventForTestPurposesWithName:kTestName];
    
    [self.daemon start];
    
    // when
    [self propagateVisitChangeForEvent:event];
    
    // then
    XCTAssertEqual(self.mockApplication.shortcutItems.count, 1);
}

- (void)testThatDaemonSkipsNonEventObjects {
    // given
    LectureModelObject *lecture = [self generateLectureForTestPurposes];
    
    [self.daemon start];
    
    // when
    [self propagateNameChangeForLecture:lecture];
    
    // then
    XCTAssertEqual(self.mockApplication.shortcutItems.count, 0);
}

- (void)testThatDaemonSkipsUpdatedEvents {
    // given
    EventModelObject *event = [self generateEventForTestPurposes];
    
    [self.daemon start];
    
    // when
    [self propagateNameChangeForEvent:event];
    
    // then
    XCTAssertEqual(self.mockApplication.shortcutItems.count, 0);
}

- (void)testThatDaemonStopsCorrectly {
    // given
    EventModelObject *event = [self generateEventForTestPurposes];
    
    [self.daemon start];
    
    // when
    [self.daemon stop];
    [self propagateVisitChangeForEvent:event];
    
    // then
    XCTAssertEqual(self.mockApplication.shortcutItems.count, 0);
}

#pragma mark - Helper methods

- (EventModelObject *)generateEventForTestPurposes {
    EventModelObject *event = [self generateEventForTestPurposesWithName:@""];
    return event;
}

- (EventModelObject *)generateEventForTestPurposesWithName:(NSString *)name {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block EventModelObject *event;
    [rootSavingContext performBlockAndWait:^{
        event = [EventModelObject MR_createEntityInContext:rootSavingContext];
        event.eventId = @"1234";
        event.name = name;
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    return event;
}

- (LectureModelObject *)generateLectureForTestPurposes {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block LectureModelObject *lecture;
    [rootSavingContext performBlockAndWait:^{
        lecture = [LectureModelObject MR_createEntityInContext:rootSavingContext];
        lecture.lectureId = @"1234";
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    return lecture;
}

- (void)propagateVisitChangeForEvent:(EventModelObject *)event {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlockAndWait:^{
        event.lastVisitDate = [NSDate date];
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
}

- (void)propagateNameChangeForEvent:(EventModelObject *)event {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlockAndWait:^{
        event.name = [[NSUUID UUID] UUIDString];
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
}

- (void)propagateNameChangeForLecture:(LectureModelObject *)lecture {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlockAndWait:^{
        lecture.name = [[NSUUID UUID] UUIDString];
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
}

- (NSArray *)generateShortcutItemsWithCount:(NSUInteger)count {
    NSMutableArray *mutableShortcutItems = [NSMutableArray new];
    for (NSUInteger i = 0; i < count; i++) {
        NSString *title = [@(i) stringValue];
        UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"test"
                                                                           localizedTitle:title
                                                                        localizedSubtitle:@"test"
                                                                                     icon:nil
                                                                                 userInfo:nil];
        [mutableShortcutItems addObject:item];
    }
    return [mutableShortcutItems copy];
}

- (UIApplicationShortcutItem *)generateShortcutItemWithName:(NSString *)name {
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"test"
                                                                       localizedTitle:name
                                                                    localizedSubtitle:@"test"
                                                                                 icon:nil
                                                                             userInfo:nil];
    return item;
}

@end
