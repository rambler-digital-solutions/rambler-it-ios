//
//  SpeakerInfoTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 20/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoTableViewCell.h"
#import "SpeakerPlainObject.h"

@interface SpeakerInfoTableViewCellObject ()

@property (nonatomic, strong, readwrite) NSString *speakerName;
@property (nonatomic, strong, readwrite) NSString *companyName;
@property (nonatomic, strong, readwrite) NSString *speakerDescription;

@end

@implementation SpeakerInfoTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithSpeaker:(SpeakerPlainObject *)speaker {
    self = [super init];
    if (self) {
        _speakerName = speaker.name;
        _companyName = speaker.company;
        _speakerDescription = speaker.biography;
    }
    
    return self;
}

+ (instancetype)objectWithSpeaker:(SpeakerPlainObject *)speaker {
    return [[self alloc] initWithSpeaker:speaker];
}

# pragma mark - NICellObject methods

- (Class)cellClass {
    return [SpeakerInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([SpeakerInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
