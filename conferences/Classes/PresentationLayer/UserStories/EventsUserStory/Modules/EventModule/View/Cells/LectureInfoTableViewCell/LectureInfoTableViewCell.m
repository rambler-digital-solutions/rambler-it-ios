//
//  SpeachTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 07/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "LectureInfoTableViewCell.h"
#import "LectureInfoTableViewCellObject.h"
#import "LectureInfoTableViewCellActionProtocol.h"
#import "EventTableViewCellActionProtocol.h"
#import "Proxying/Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";

static CGFloat const kLectionInfoTableViewCellHeight = 340.0f;

@interface LectureInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *speakerImageView;
@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UILabel *speakerCompanyName;
@property (weak, nonatomic) IBOutlet UITextView *lectureDescription;
@property (weak, nonatomic) IBOutlet UILabel *lectureTitle;

@property (weak, nonatomic) id <LectureInfoTableViewCellActionProtocol> actionProxy;

@end

@implementation LectureInfoTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<LectureInfoTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(LectureInfoTableViewCellObject *)object {
    self.speakerName.text = object.speakerName;
    self.speakerCompanyName.text = object.speakerCompanyName;
    self.lectureDescription.text = object.lectureDescription;
    self.lectureTitle.text = object.lectureTitle;
    [self.speakerImageView sd_setImageWithURL:object.speakerImageLink
                             placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kLectionInfoTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapReadMoreButton:(UIButton *)sender {
    [self.actionProxy didTapReadMoreLectureDescriptionButton:sender];
}

@end
