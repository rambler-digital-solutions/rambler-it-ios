//
//  SpeakerInfoSocialContactsCellObject.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 03/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoSocialContactsCellObject.h"
#import "SocialNetworkAccountPlainObject.h"
#import "SpeakerInfoSocialContactsTableViewCell.h"

@implementation SpeakerInfoSocialContactsCellObject

- (instancetype)initWithSocialNetworkAccount:(SocialNetworkAccountPlainObject *)account
                                       image:(UIImage *)image
                                        text:(NSString *)text {
    self = [super init];
    if (self) {
        _image = image;
        _link = account.profileLink;
        _name = text;
    }
    
    return self;
}

+ (instancetype)objectWithSocialNetworkAccount:(SocialNetworkAccountPlainObject *)account
                                         image:(UIImage *)image
                                          text:(NSString *)text {
    return [[self alloc] initWithSocialNetworkAccount:account
                                                image:image
                                                 text:text];
}

# pragma mark - NICellObject methods

- (Class)cellClass {
    return [SpeakerInfoSocialContactsTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([SpeakerInfoSocialContactsTableViewCell class])
                          bundle:[NSBundle mainBundle]];
}

@end
