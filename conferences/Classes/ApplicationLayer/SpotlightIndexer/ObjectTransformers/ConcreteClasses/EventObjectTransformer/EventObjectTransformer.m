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

#import "EventObjectTransformer.h"

#import "EventModelObject.h"

#import <MagicalRecord/MagicalRecord.h>

static NSString *const kIdentifierSeparator = @"_";

@implementation EventObjectTransformer

#pragma mark - <ObjectTransformer>

- (NSString *)identifierForObject:(EventModelObject *)object {
    NSString *objectType = NSStringFromClass([EventModelObject class]);
    NSString *eventId = object.eventId;
    NSString *identifier = [NSString stringWithFormat:@"%@%@%@", objectType, kIdentifierSeparator, eventId];
    return identifier;
}

- (EventModelObject *)objectForIdentifier:(NSString *)identifier {
    NSString *eventId = [[identifier componentsSeparatedByString:kIdentifierSeparator] lastObject];
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    EventModelObject *event = [EventModelObject MR_findFirstByAttribute:NSStringFromSelector(@selector(eventId))
                                                              withValue:eventId
                                                              inContext:defaultContext];
    return event;
}

- (BOOL)isCorrectIdentifier:(NSString *)identifier {
    NSString *objectType = NSStringFromClass([EventModelObject class]);
    
    BOOL hasCorrectObjectType = [identifier rangeOfString:objectType].location != NSNotFound;
    
    BOOL hasSeparator = [identifier rangeOfString:kIdentifierSeparator].location != NSNotFound;
    
    NSUInteger eventIdLocation = objectType.length + 1; // 1 for _ symbol
    NSUInteger eventIdLength = identifier.length - eventIdLocation;
    BOOL hasEventId = eventIdLength > 0;
    
    return hasCorrectObjectType != NO && hasSeparator != NO && hasEventId != NO;
}

@end
