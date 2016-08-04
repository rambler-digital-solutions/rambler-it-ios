//
//  SpeakerInfoSectionHeaderTableViewCell.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 04/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoSectionHeaderTableViewCell.h"
#import "SpeakerInfoSectionHeaderCellObject.h"

@interface SpeakerInfoSectionHeaderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *sectionName;

@end

@implementation SpeakerInfoSectionHeaderTableViewCell

- (BOOL)shouldUpdateCellWithObject:(SpeakerInfoSectionHeaderCellObject *)object {
    
    self.sectionName.text = object.text;
    
    return YES;
}

@end
