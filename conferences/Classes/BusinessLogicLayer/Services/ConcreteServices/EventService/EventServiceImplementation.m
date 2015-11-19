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

#import "EventServiceImplementation.h"

#import "CompoundOperationBase.h"
#import "EventOperationFactory.h"
#import "OperationScheduler.h"
#import "Event.h"

@implementation EventServiceImplementation

- (void)updateEventWithPredicate:(NSPredicate *)predicate completionBlock:(EventCompletionBlock)completionBlock {
    CompoundOperationBase *compoundOperation = [self.eventOperationFactory getEventsOperationWithQuery:nil];
    compoundOperation.resultBlock = ^void(id data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data, error);
        });
    };
    
    [self.operationScheduler addOperation:compoundOperation];
}

- (NSArray *)obtainEventWithPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSArray *events = [Event MR_findAllWithPredicate:predicate inContext:context];
    
    return events;
}

@end
