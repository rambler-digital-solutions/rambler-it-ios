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

#import <MagicalRecord/MagicalRecord.h>
#import "NSManagedObjectID+LJStringConversion.h"

#import "EventServiceImplementation.h"
#import "EventOperationFactory.h"
#import "CompoundOperationBase.h"
#import "LastModifiedModelObject.h"
#import "OperationScheduler.h"
#import "EventModelObject.h"
#import "EventListQuery.h"
#import "ROSPonsomizer.h"

static NSString *const kEventListName = @"kEventListName";

@implementation EventServiceImplementation

- (NSArray *)obtainEventsWithPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSArray *events = [EventModelObject MR_findAllWithPredicate:predicate inContext:context];
    
    return events;
}

- (void)updateEventListWithCompletionBlock:(EventsCompletionBlock)completionBlock
{
    EventListQuery *listQuery = [self obtainActualEventListObject];
    NSString *modelObjectId = [self obtainCurrentEventModelObjectId];
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlock:^{
        CompoundOperationBase *compoundOperation = [self.eventOperationFactory getEventsOperationWithQuery:listQuery
                                                                                             modelObjectId:modelObjectId];
        
        compoundOperation.resultBlock = ^void(id data, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(error);
            });
        };
        
        [self.operationScheduler addOperation:compoundOperation];
    }];
}

- (void)setupPredefinedEventListIfNeeded {
    [self setupPredefinedEventListWithName:kEventListName];
}

#pragma mark - private methods

- (void)setupPredefinedEventListWithName:(NSString *)eventListName {
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    LastModifiedModelObject *eventListObject = [LastModifiedModelObject MR_findFirstByAttribute:NSStringFromSelector(@selector(name)) withValue:eventListName inContext:defaultContext];
    if (eventListObject) {
        return;
    }
    
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlockAndWait:^{
        LastModifiedModelObject *eventListObject = [LastModifiedModelObject MR_findFirstByAttribute:NSStringFromSelector(@selector(name)) withValue:eventListName inContext:rootSavingContext];
        if (!eventListObject) {
            eventListObject = [LastModifiedModelObject MR_createEntityInContext:rootSavingContext];
            eventListObject.name = eventListName;
            eventListObject.lastModifiedId = [[NSUUID UUID] UUIDString];
            eventListObject.lastModifiedDate = [NSDate dateWithTimeIntervalSince1970:0];
        }
        
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
}

- (EventListQuery *)obtainActualEventListObject {
    LastModifiedModelObject *modelObject = [LastModifiedModelObject MR_findFirst];
    EventListQuery *eventListQuery = [EventListQuery new];
    
    NSTimeInterval interval = [modelObject.lastModifiedDate timeIntervalSince1970];
    eventListQuery.lastModifiedString = [NSString stringWithFormat:@"%d",(int)interval];
    
    return eventListQuery;
}

- (NSString *)obtainCurrentEventModelObjectId{
    LastModifiedModelObject *modelObject = [LastModifiedModelObject MR_findFirst];
    NSString *modelObjectID = [[modelObject objectID] stringRepresentation];
    return modelObjectID;
}

@end
