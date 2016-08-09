//
// TagCollectionViewCell.m
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagCollectionViewCell.h"
#import "TagCollectionViewCellObject.h"
#import "TagCellDelegate.h"
#import <PureLayout/PureLayout.h>

const CGFloat kRightSpace = 10;
const CGFloat kButtonWidth = 10;
const CGFloat kRightSpaceWithButton = 22;

NSString *const kDeleteTagButtonImageName = @"delete-tag-icon";

@interface TagCollectionViewCell ()

@property (nonatomic, strong) TagCollectionViewCellObject *cellObject;
@property (nonatomic, strong) UIButton *removeButton;

@end

@implementation TagCollectionViewCell

- (BOOL)shouldUpdateCellWithObject:(TagCollectionViewCellObject *)object {

    if ([self.cellObject isEqual:object]) {
        return NO;
    }

    self.cellObject = object;
    self.tagLabel.text = object.tagName;

    if (self.cellObject.enableRemoveButton) {
        [self createRemoveButton];
    }
    else {
        [self deleteRemoveButton];
    }

    return YES;
}

- (void)createRemoveButton {
    
    if (self.removeButton) {
        return;
    }
    
    self.removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:kDeleteTagButtonImageName];
    [self.removeButton setImage:image
                       forState:UIControlStateNormal];

    [self.removeButton addTarget:self
                          action:@selector(didTapRemoveButton:)
                forControlEvents:UIControlEventTouchUpInside];

    self.removeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.removeButton];

    // Constraints
    [self.removeButton autoPinEdge:ALEdgeTrailing
                            toEdge:ALEdgeTrailing
                            ofView:self
                        withOffset:-kRightSpace];

    [self.removeButton autoSetDimension:ALDimensionWidth
                                 toSize:kButtonWidth];

    self.trailingTagLabelConstraint.constant = kRightSpaceWithButton;
}

- (void)deleteRemoveButton {
    
    if (!self.removeButton) {
        return;
    }
    
    [self.removeButton removeFromSuperview];
    self.removeButton = nil;
    self.trailingTagLabelConstraint.constant = kRightSpace;
}

- (IBAction)didTapRemoveButton:(id)sender {
    [self.cellObject.delegate didTapRemoveTag:self.cellObject];
}

@end