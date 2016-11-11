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

#import <Foundation/Foundation.h>

@class MSMessage, EventPlainObject;

@protocol MessagesInteractorInput <NSObject>

/**
 @author Trishina Ekaterina

 Method is used to create message object from EventPlainObject

 @return NSMessage object
 */
- (MSMessage *)createMessageFromEvent:(EventPlainObject *)event;

/**
 @author Trishina Ekaterina

 Method is used to obtain list of events

 @return Array of PlainEvent objects
 */
- (NSArray *)obtainEventList;

/**
 @author Trishina Ekaterina

 Method is used to testify the identifier

 @return BOOL for correct value
 */
- (BOOL)isCorrectIdentifier:(NSString *)identifier;

/**
 @author Trishina Ekaterina

 Method is used to setup CoreData stack
 */
- (void)setupCoreDataStack;

@end
