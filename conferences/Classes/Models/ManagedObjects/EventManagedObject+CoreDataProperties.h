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

#import "EventManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *backgroundColor;
@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSString *eventDescription;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *liveStreamLink;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *objectId;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSString *tags;
@property (nullable, nonatomic, retain) NSString *timePadID;
@property (nullable, nonatomic, retain) NSString *twitterLink;
@property (nullable, nonatomic, retain) NSSet<LectureManagedObject *> *lectures;
@property (nullable, nonatomic, retain) NSSet<RegistrationQuestionManagedObject *> *registrationQuestions;
@property (nullable, nonatomic, retain) MetaEventManagedObject *metaEvent;

@end

@interface EventManagedObject (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(LectureManagedObject *)value;
- (void)removeLecturesObject:(LectureManagedObject *)value;
- (void)addLectures:(NSSet<LectureManagedObject *> *)values;
- (void)removeLectures:(NSSet<LectureManagedObject *> *)values;

- (void)addRegistrationQuestionsObject:(RegistrationQuestionManagedObject *)value;
- (void)removeRegistrationQuestionsObject:(RegistrationQuestionManagedObject *)value;
- (void)addRegistrationQuestions:(NSSet<RegistrationQuestionManagedObject *> *)values;
- (void)removeRegistrationQuestions:(NSSet<RegistrationQuestionManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
