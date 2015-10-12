//
//  TabBarButtonCell.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 11/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDSCollectionViewCellProtocol.h"

@interface TabBarButtonCell : UICollectionViewCell<RDSCollectionViewCellProtocol>

@property (nonatomic,strong) UIColor *selectionTint;
@property (nonatomic,strong) UIColor *idleTint;

@property (nonatomic,weak) IBOutlet UIImageView *tabIcon;
@property (nonatomic,weak) IBOutlet UILabel *tabLabel;

@end
