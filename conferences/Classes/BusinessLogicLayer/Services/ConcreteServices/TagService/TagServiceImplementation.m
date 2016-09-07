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

#import "TagServiceImplementation.h"
#import "TagModelObject.h"
#import "TagServicePredicateBuilder.h"
#import "TagObjectDescriptor.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LectureModelObject.h"

@implementation TagServiceImplementation

#pragma mark - Метод TagService

- (NSArray *)obtainTagsFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {

    NSParameterAssert(objectDescriptor);

    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];

    NSOrderedSet *tags = [self tagsFromObjectDescriptor:objectDescriptor
                                              inContext:defaultContext];

    return [tags array];
}
#pragma mark - Дополнительные методы

- (id)obtainObjectWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                                            inContext:(NSManagedObjectContext *)context {

    NSPredicate *predicate = [self.predicateBuilder buildGetObjectPredicateFromObjectDescriptor:objectDescriptor];
    NSFetchRequest *request = [NSClassFromString(objectDescriptor.objectName) MR_requestFirstWithPredicate:predicate];
    NSManagedObject *object = [NSClassFromString(objectDescriptor.objectName) MR_executeFetchRequestAndReturnFirstObject:request
                                                                                                               inContext:context];

    return object;
}

- (TagModelObject *)obtainTagWithName:(NSString *)name
                             inObject:(id)object {
    // Ищем тег у объекта
    NSSet *tags = [object tags];
    for (TagModelObject *tag in tags) {
        if ([tag.name isEqual:name]) {
            return tag;
        }
    }

    return nil;
}

- (NSOrderedSet *)tagsFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                                 inContext:(NSManagedObjectContext *)context {
    NSPredicate *objectPredicate = [self.predicateBuilder buildGetObjectPredicateFromObjectDescriptor:objectDescriptor];


    Class objectClass = NSClassFromString(objectDescriptor.objectName);
    NSFetchRequest *request = [objectClass MR_requestFirstWithPredicate:objectPredicate];
    id object = [objectClass MR_executeFetchRequestAndReturnFirstObject:request
                                                              inContext:context];

    NSOrderedSet *tags = [NSOrderedSet orderedSetWithArray:[[object tags] allObjects]];
    return tags;
}

@end