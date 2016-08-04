//
//  SpeakerInfoSocialContactsTableViewCell.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 03/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoSocialContactsTableViewCell.h"
#import "SpeakerInfoSocialContactsCellObject.h"

@interface SpeakerInfoSocialContactsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *socailNetworkIcon;
@property (weak, nonatomic) IBOutlet UILabel *socialNetworkName;


@end

@implementation SpeakerInfoSocialContactsTableViewCell

- (BOOL)shouldUpdateCellWithObject:(SpeakerInfoSocialContactsCellObject *)object {
    
    self.socailNetworkIcon.image = [UIImage imageNamed:object.image];
    self.socialNetworkName.text = object.name;
    
    return YES;
}

@end
