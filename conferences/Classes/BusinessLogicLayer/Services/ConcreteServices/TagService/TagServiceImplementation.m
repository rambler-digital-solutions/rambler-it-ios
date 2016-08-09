//
// TagServiceImplementation.m
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagServiceImplementation.h"
#import "TagModelObject.h"
#import "TagServicePredicateBuilder.h"
#import "TagObjectDescriptor.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LectureModelObject.h"

@implementation TagServiceImplementation

#pragma mark - Метод TagService

- (NSArray *)obtainTagsFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                    excludeObjectDescriptor:(TagObjectDescriptor *)excludeObjectDescriptor {

    NSParameterAssert(objectDescriptor);

    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];

    NSOrderedSet *tags = [self tagsFromObjectDescriptor:objectDescriptor
                                              inContext:defaultContext];


    // Предикат, что тег не включен в объект
    if (excludeObjectDescriptor) {

        NSOrderedSet *excludeTags = [self tagsFromObjectDescriptor:excludeObjectDescriptor
                                                             inContext:defaultContext];

        NSOrderedSet *excludeTagNames = [excludeTags valueForKey:TagModelObjectAttributes.name];

        NSPredicate *filteredPredicate = [self.predicateBuilder buildExcludeTagsByNames:[excludeTagNames array]];

        tags = [tags filteredOrderedSetUsingPredicate:filteredPredicate];
    }

    return [tags array];
}

- (void)addTagWithName:(NSString *)tagName
   forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {

    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {

        LectureModelObject *object = [self obtainObjectWithObjectDescriptor:objectDescriptor
                                                 inContext:localContext];

        // Проверяем, чтобы такого ката не было у объекта
        TagModelObject *tagModelObject = [self obtainTagWithName:tagName
                                                        inObject:object];
        if (!tagModelObject) {
            tagModelObject = [TagModelObject MR_createEntityInContext:localContext];
            tagModelObject.name = tagName;
            [object addTagsObject:tagModelObject];
        }
    }];
}

- (void)removeTagWithName:(NSString *)tagName
      forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {

        id object = [self obtainObjectWithObjectDescriptor:objectDescriptor
                                                 inContext:localContext];

        TagModelObject *tagModelObject = [self obtainTagWithName:tagName
                                                        inObject:object];

        [tagModelObject MR_deleteEntityInContext:localContext];
    }];
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

    NSOrderedSet *tags = (id) [object tags];

    return tags;
}

@end