//
//  SpeakerInfoTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 20/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoTableViewCell.h"
#import "SpeakerInfoTableViewCellObject.h"

@interface SpeakerInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *speakerImageView;
@property (weak, nonatomic) IBOutlet UILabel *speakerNameTitle;
@property (weak, nonatomic) IBOutlet UILabel *companyNameTitle;
@property (weak, nonatomic) IBOutlet UILabel *speakerDescription;

@end

@implementation SpeakerInfoTableViewCell

#pragma mark NICell methods

- (BOOL)shouldUpdateCellWithObject:(SpeakerInfoTableViewCellObject *)object {
    self.speakerNameTitle.text = object.speakerName;
    self.companyNameTitle.text = object.companyName;
    self.speakerDescription.text = object.speakerDescription;
    
    return  true;
}

@end
