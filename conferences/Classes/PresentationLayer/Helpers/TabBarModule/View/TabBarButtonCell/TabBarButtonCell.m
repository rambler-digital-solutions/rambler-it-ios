//
//  TabBarButtonCell.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 11/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "TabBarButtonCell.h"
#import "TabBarButtonPrototypeProtocol.h"

@interface TabBarButtonCell()

@property (nonatomic,strong) UIImage *idleStateTabImage;
@property (nonatomic,strong) UIImage *selectedStateTabImage;

@end

@implementation TabBarButtonCell


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateSelectionState];
}

- (void)updateSelectionState {
    self.tabIcon.image = (self.selected) ? self.selectedStateTabImage : self.idleStateTabImage;
    self.tabLabel.textColor = (self.selected) ? self.selectionTint : self.idleTint;
}

#pragma mark - rcCollectionViewCell

- (void)configureWithObject:(id<TabBarButtonPrototypeProtocol>)object {
    
    self.idleStateTabImage = [object tabBarButtonIdleStateImage];
    self.selectedStateTabImage = [object tabBarButtonSelectedStateImage];
    [self updateSelectionState];
    self.tabLabel.text = [object tabBarButtonTitle];
}

@end
