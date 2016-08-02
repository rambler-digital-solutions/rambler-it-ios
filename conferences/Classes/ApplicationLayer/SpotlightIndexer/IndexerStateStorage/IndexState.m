//
//  IndexState.m
//  Conferences
//
//  Created by Egor Tolstoy on 02/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "IndexState.h"

@implementation IndexState

- (void)insertIdentifier:(NSString *)identifier
                 forType:(NSUInteger)type {
    [self insertIdentifiers:@[identifier]
                    forType:type];
}

- (void)removeIdentifier:(NSString *)identifier
                 forType:(NSUInteger)type {
    [self removeIdentifiers:@[identifier]
                    forType:type];
}

- (void)insertIdentifiers:(NSArray *)identifiers
                  forType:(NSUInteger)type {
    NSMutableOrderedSet *set = [self obtainIdentifierWithType:type];
    [set addObjectsFromArray:identifiers];
    [self saveIdentifiers:set
                 withType:type];
    self.numberOfIdentifiers = [self calculateCurrentNumberOfIdentifiers];
}

- (void)removeIdentifiers:(NSArray *)identifiers
                  forType:(NSUInteger)type {
    NSMutableOrderedSet *set = [self obtainIdentifierWithType:type];
    [set removeObjectsInArray:identifiers];
    [self saveIdentifiers:set
                 withType:type];
    self.numberOfIdentifiers = [self calculateCurrentNumberOfIdentifiers];
}

- (NSUInteger)typeForIdentifiersSet:(NSMutableOrderedSet *)identifiersSet {
    NSDictionary *mapDict = [self mapTypeToSet];
    NSArray *keys = [mapDict allKeysForObject:identifiersSet];
    NSNumber *numberType = keys.firstObject;
    return [numberType unsignedIntegerValue];
}

- (NSMutableOrderedSet *)identifiersSetForType:(NSUInteger)type {
    NSDictionary *mapDict = [self mapTypeToSet];
    return mapDict[@(type)];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"IndexState : [%@] \n objectType : %@ %@", self, self.objectType, [self mapTypeToSet]];
}

- (NSNumber *)calculateCurrentNumberOfIdentifiers {
    NSArray *array = @[self.insertIdentifiers?: [NSMutableOrderedSet new],
                       self.updateIdentifiers?: [NSMutableOrderedSet new],
                       self.deleteIdentifiers?: [NSMutableOrderedSet new],
                       self.moveIdentifiers?: [NSMutableOrderedSet new]];
    NSUInteger count = 0;
    for (NSOrderedSet *set in array) {
        count += [set count];
    }
    return @(count);
}

- (NSMutableOrderedSet *)obtainIdentifierWithType:(NSUInteger)type {
    NSDictionary *mapReadSelectorDict = [self mapReadSelectorToChangeType];
    NSString *stringReadSelector = mapReadSelectorDict[@(type)];
    NSMutableOrderedSet *set;
    set = [self performSelector:NSSelectorFromString(stringReadSelector)];
    return set ? [set mutableCopy] : [NSMutableOrderedSet new];
}

- (void)saveIdentifiers:(NSMutableOrderedSet *)identifiers withType:(NSUInteger)type {
    NSDictionary *mapWriteSelectorDict = [self mapWriteSelectorToChangeType];
    NSString *stringWriteSelector = mapWriteSelectorDict[@(type)];
    [self performSelector:NSSelectorFromString(stringWriteSelector) withObject:identifiers];
}

- (NSDictionary *)mapTypeToSet {
    return @{ @(NSFetchedResultsChangeInsert) : self.insertIdentifiers ?: [NSMutableOrderedSet new],
              @(NSFetchedResultsChangeUpdate) : self.updateIdentifiers ?: [NSMutableOrderedSet new],
              @(NSFetchedResultsChangeDelete) : self.deleteIdentifiers ?: [NSMutableOrderedSet new],
              @(NSFetchedResultsChangeMove) : self.moveIdentifiers ?: [NSMutableOrderedSet new]};
}

- (NSDictionary *)mapReadSelectorToChangeType {
    return @{ @(NSFetchedResultsChangeInsert) : NSStringFromSelector(@selector(insertIdentifiers)),
              @(NSFetchedResultsChangeUpdate) : NSStringFromSelector(@selector(updateIdentifiers)),
              @(NSFetchedResultsChangeDelete) : NSStringFromSelector(@selector(deleteIdentifiers)),
              @(NSFetchedResultsChangeMove) : NSStringFromSelector(@selector(moveIdentifiers))};
}

- (NSDictionary *)mapWriteSelectorToChangeType {
    return @{ @(NSFetchedResultsChangeInsert) : NSStringFromSelector(@selector(setInsertIdentifiers:)),
              @(NSFetchedResultsChangeUpdate) : NSStringFromSelector(@selector(setUpdateIdentifiers:)),
              @(NSFetchedResultsChangeDelete) : NSStringFromSelector(@selector(setDeleteIdentifiers:)),
              @(NSFetchedResultsChangeMove) : NSStringFromSelector(@selector(setMoveIdentifiers:))};
}

@end
