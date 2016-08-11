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

#import "LectureObjectTransformer.h"

#import "LectureModelObject.h"
#import "ObjectTransformerConstants.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation LectureObjectTransformer

#pragma mark - <ObjectTransformer>

- (NSString *)identifierForObject:(LectureModelObject *)object {
    NSString *objectType = NSStringFromClass([LectureModelObject class]);
    NSString *lectureId = object.lectureId;
    NSString *identifier = [NSString stringWithFormat:@"%@%@%@", objectType, kIdentifierSeparator, lectureId];
    return identifier;
}

- (LectureModelObject *)objectForIdentifier:(NSString *)identifier {
    NSString *lectureId = [[identifier componentsSeparatedByString:kIdentifierSeparator] lastObject];
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    LectureModelObject *lecture = [LectureModelObject MR_findFirstByAttribute:NSStringFromSelector(@selector(lectureId))
                                                                    withValue:lectureId
                                                                    inContext:defaultContext];
    return lecture;
}

- (BOOL)isCorrectIdentifier:(NSString *)identifier {
    NSString *objectType = NSStringFromClass([LectureModelObject class]);
    
    BOOL hasCorrectObjectType = [identifier rangeOfString:objectType].location != NSNotFound;
    
    BOOL hasSeparator = [identifier rangeOfString:kIdentifierSeparator].location != NSNotFound;
    
    NSUInteger lectureIdLocation = objectType.length + 1; // 1 for _ symbol
    NSInteger lectureIdLength = identifier.length - lectureIdLocation;
    BOOL hasLectureId = lectureIdLength > 0;
    
    return hasCorrectObjectType && hasSeparator && hasLectureId;
}

@end
