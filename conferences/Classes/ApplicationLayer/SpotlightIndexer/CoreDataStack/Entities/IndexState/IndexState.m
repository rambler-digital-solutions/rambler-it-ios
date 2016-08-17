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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    set = [self performSelector:NSSelectorFromString(stringReadSelector)];
#pragma clang diagnostic pop
    return set ? [set mutableCopy] : [NSMutableOrderedSet new];
}

- (void)saveIdentifiers:(NSMutableOrderedSet *)identifiers withType:(NSUInteger)type {
    NSDictionary *mapWriteSelectorDict = [self mapWriteSelectorToChangeType];
    NSString *stringWriteSelector = mapWriteSelectorDict[@(type)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(stringWriteSelector) withObject:identifiers];
#pragma clang diagnostic pop
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
