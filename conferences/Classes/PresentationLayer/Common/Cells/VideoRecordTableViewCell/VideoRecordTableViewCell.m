// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VideoRecordTableViewCell.h"
#import "VideoRecordTableViewCellObject.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"
#import "LectureMaterialViewModel.h"
#import "LectureMaterialCacheDelegate.h"
#import <MBCircularProgressBarView.h>

static CGFloat const kVideoRecordTableViewCellHeight = 168.0f;
static NSInteger const kCacheButtonCornerRadius = 15.0f;
static NSString *const kPlaceholderImageName = @"placeholder";

@interface VideoRecordTableViewCell ()

@property (nonatomic, weak) id <LectureMaterialCacheDelegate> actionProxy;
@property (nonatomic, strong) LectureMaterialViewModel *videoMaterial;

@end

@implementation VideoRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.circleProgressBar.unitString = @"%";
    self.circleProgressBar.progressAngle = 100;
    self.circleProgressBar.progressLineWidth = 3;
    self.circleProgressBar.progressColor = [UIColor whiteColor];
    self.circleProgressBar.progressStrokeColor = [UIColor whiteColor];
    self.circleProgressBar.progressCapType = 1;
    self.circleProgressBar.valueFontSize = 10;
    self.circleProgressBar.fontColor = [UIColor whiteColor];
    self.circleProgressBar.emptyLineColor = [UIColor lightTextColor];
    self.circleProgressBar.emptyLineWidth = 0.5;
    self.circleProgressBar.value = 0;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<LectureMaterialCacheDelegate>)[self cd_proxyForProtocol:@protocol(LectureMaterialCacheDelegate)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(VideoRecordTableViewCellObject *)object {
    self.videoMaterial = object.videoMaterial;
    if (object.previewImageUrl) {
        [self setupPreviewStateWithObject:object];
    } else {
        [self setupNoVideoStateWithObject:object];
    }
    
    self.removeButton.layer.cornerRadius = kCacheButtonCornerRadius;
    self.downloadButton.layer.cornerRadius = kCacheButtonCornerRadius;
    self.circleProgressBar.layer.cornerRadius = kCacheButtonCornerRadius;
    
    if ([object.videoMaterial.isDownloading boolValue]) {
        [self.removeButton setHidden:YES];
        [self.downloadButton setHidden:YES];
        [self.circleProgressBar setHidden:NO];
        self.circleProgressBar.value = [object.videoMaterial.percent floatValue];
        return YES;
    }
    BOOL isVideoCached = object.videoMaterial.localURL.length != 0;
    
    [self.removeButton setHidden:!isVideoCached];
    [self.downloadButton setHidden:isVideoCached];
    [self.circleProgressBar setHidden:YES];
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kVideoRecordTableViewCellHeight;
}

#pragma mark - IBAction

- (IBAction)didTapRemoveFromCacheVideoMaterial:(id)sender {
    [self.actionProxy didTapRemoveFromCacheLectureMaterial:self.videoMaterial];
}

- (IBAction)didTapDownloadToCacheVideoMaterial:(id)sender {
    [self.actionProxy didTapDownloadToCacheLectureMaterial:self.videoMaterial];
}

#pragma mark - Private methods

- (void)setupPreviewStateWithObject:(VideoRecordTableViewCellObject *)object {
    self.titleLabel.hidden = YES;
    self.playIconImageView.hidden = NO;
    [self.previewImageView sd_setImageWithURL:object.previewImageUrl
                             placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
}

- (void)setupNoVideoStateWithObject:(VideoRecordTableViewCellObject *)object {
    self.titleLabel.hidden = NO;
    self.playIconImageView.hidden = YES;
    self.previewImageView.image = [UIImage imageNamed:kPlaceholderImageName];
}

@end
