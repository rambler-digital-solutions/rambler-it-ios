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

#import "SuggestServiceImplementation.h"

#import "EventModelObject.h"
#import "SpeakerModelObject.h"
#import "LectureModelObject.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation SuggestServiceImplementation

#pragma mark - <SuggestService>

- (NSArray<NSString *> *)obtainRandomSuggestsWithCount:(NSUInteger)count {
    NSMutableArray *mutableSuggests = [NSMutableArray new];
    for (NSUInteger i = 0; i < count; i++) {
        NSString *suggest = [self generateRandomSuggest];
        
        while ([mutableSuggests containsObject:suggest]) {
            suggest = [self generateRandomSuggest];
        }
        [mutableSuggests addObject:suggest];
    }
    return [mutableSuggests copy];
}

#pragma mark - Private methods

- (NSString *)generateRandomSuggest {
    NSArray *modelClassArray = [self modelClassArray];
    NSInteger classCount = modelClassArray.count;
    NSUInteger classIndex = arc4random_uniform((int)classCount);
    Class modelClass = NSClassFromString(modelClassArray[classIndex]);
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    NSUInteger overallModelCount = [modelClass MR_countOfEntitiesWithContext:defaultContext];
    NSInteger modelIndex = arc4random_uniform((int)overallModelCount);
    
    NSArray *models = [modelClass MR_findAllInContext:defaultContext];
    NSManagedObject *object = models[modelIndex];
    
    SEL nameSelector = @selector(name);
    NSString *result;
    if ([object respondsToSelector:nameSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        result = [object performSelector:nameSelector];
#pragma clang diagnostic pop
    }
    return result;
}

- (NSArray *)modelClassArray {
    static NSArray *modelClassArray;
    if (!modelClassArray) {
        modelClassArray = @[
                            NSStringFromClass([EventModelObject class]),
                            NSStringFromClass([SpeakerModelObject class]),
                            NSStringFromClass([LectureModelObject class])
                            ];
    }
    return modelClassArray;
}

@end
