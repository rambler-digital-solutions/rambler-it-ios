//
//  TagInteractor.m
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import "TagInteractor.h"

#import "TagService.h"
#import "TagObjectDescriptor.h"
#import "TagModelObject.h"

@implementation TagInteractor

#pragma mark - Методы TagInteractorInput

- (NSArray *)obtainTagsFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                    excludeObjectDescriptor:(TagObjectDescriptor *)excludeObjectDescriptor {
    NSArray *tags = [self.tagService obtainTagsFromObjectDescriptor:objectDescriptor
                                            excludeObjectDescriptor:excludeObjectDescriptor];

    return [self plainStringFromObjects:tags];
}

- (void)addTagWithName:(NSString *)tagName
   forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    [self.tagService addTagWithName:tagName
                forObjectDescriptor:objectDescriptor];
}

- (void)removeTagWithName:(NSString *)tagName
      forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    [self.tagService removeTagWithName:tagName
                   forObjectDescriptor:objectDescriptor];
}

#pragma mark - Дополнительные методы

- (NSArray *)plainStringFromObjects:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (TagModelObject *tag in array) {
        [result addObject:tag.name];
    }
    return [result copy];
}


@end