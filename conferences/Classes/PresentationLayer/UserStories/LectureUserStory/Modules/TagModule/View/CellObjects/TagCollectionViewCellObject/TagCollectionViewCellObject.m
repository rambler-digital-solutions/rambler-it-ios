//
// TagCollectionViewCellObject.m
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagCollectionViewCellObject.h"
#import "TagCollectionViewCell.h"
#import "TagCellDelegate.h"


@implementation TagCollectionViewCellObject

- (instancetype)initWithTagName:(NSString *)tagName
             enableRemoveButton:(BOOL)enableRemoveButton
                       delegate:(id <TagCellDelegate>)delegate {
    self = [super init];
    if (self) {
        _tagName = tagName;
        _enableRemoveButton = enableRemoveButton;
        _delegate = delegate;
    }

    return self;
}

- (UINib *)collectionViewCellNib {
    NSString *className = NSStringFromClass([TagCollectionViewCell class]);
    NSBundle *bundle = [NSBundle mainBundle];
    UINib *nib = [UINib nibWithNibName:className
                                bundle:bundle];
    return nib;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    TagCollectionViewCellObject *otherCellObject = other;

    return self.enableRemoveButton == otherCellObject.enableRemoveButton
            && [self.tagName isEqual:otherCellObject.tagName]
            && [self.delegate isEqual:otherCellObject.delegate];
}


@end