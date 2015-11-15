//
//  CurrentVideoTranslationTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "CurrentVideoTranslationTableViewCell.h"
#import "CurrentVideoTranslationTableViewCellObject.h"
#import "CurrentVideoTranslationTableViewCellActionProtocol.h"
#import "EventTableViewCellActionProtocol.h"
#import "Proxying/Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"

static CGFloat const kCurrentVideoTranslationTableViewCellHeight = 60.0f;

@interface CurrentVideoTranslationTableViewCell ()

@property (weak, nonatomic) id <CurrentVideoTranslationTableViewCellActionProtocol> actionProxy;

@end

@implementation CurrentVideoTranslationTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<CurrentVideoTranslationTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(CurrentVideoTranslationTableViewCellObject *)object {
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kCurrentVideoTranslationTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapCurrentTranslationButton:(UIButton *)sender {
    [self.actionProxy didTapCurrentTranslationButton:sender];
}

@end
