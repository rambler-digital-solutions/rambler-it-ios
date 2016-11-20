// Copyright (c) 2016 RAMBLER&Co
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

#import "LectureViewController.h"

#import "LectureViewOutput.h"
#import "LectureDataDisplayManager.h"
#import "SpeakerPlainObject.h"
#import "LecturePlainObject.h"
#import "SpeakerShortInfoModuleInput.h"

#import "UINavigationBar+States.h"
#import "Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h"
#import "UIViewController+RCFForceRotation.h"
#import "TagModuleTableViewCell.h"
#import "CollectionViewContentCellAnimator.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

static CGFloat kTableViewEstimatedRowHeight = 44.0f;
static CGFloat kTableViewFooterHeight = 16.0f;

@implementation LectureViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self cd_startObserveProtocols:@[@protocol(LectureInfoTableViewCellActionProtocol),
                                     @protocol(TagTableViewCellDelegate),
                                     @protocol(LectureMaterialCacheDelegate)]];
    [self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [self rcf_forceRotateToOrientation:UIDeviceOrientationPortrait];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - LectureViewInput

- (void)configureViewWithLecture:(LecturePlainObject *)lecture {
    [self.dataDisplayManager configureDataDisplayManagerWithLecture:lecture];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView
                                                           withBaseDelegate:nil];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kTableViewFooterHeight)];
    
    self.tableView.estimatedRowHeight = kTableViewEstimatedRowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setupViewInitialState];
}

#pragma mark - <LectureDataDisplayManagerDelegate>

- (void)didTapVideoRecordCellWithVideoMaterial:(LectureMaterialPlainObject *)videoMaterial; {
    [self.output didTapVideoPreviewWithVideoMaterial:videoMaterial];
}

- (void)didTapMaterialCellWithUrl:(NSURL *)materialUrl {
    [self.output didTapMaterialWithUrl:materialUrl];
}

#pragma mark - <LectureInfoTableViewCellActionProtocol>

- (void)didSpeakerViewWithSpeakerId:(NSString *)speakerId {
    [self.output didTapSpeakerWithId:speakerId];
}

#pragma mark - LectureMaterialCacheDelegate

- (void)didTapRemoveFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Удалить"
                                                                             message:@"Вы уверены?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Удалить"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
      [self.output didTapRemoveFromCacheLectureMaterial:lectureMaterial];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (void)didTapDownloadToCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Скачать"
                                                                             message:@"Вы уверены?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Скачать"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        [self.output didTapDownloadToCacheLectureMaterial:lectureMaterial];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
    
}

#pragma mark - Private methods

- (void)setupViewInitialState {
    [self.navigationController.navigationBar rcf_becomeTransparent];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.hidden = NO;
    self.animator.tableView = self.tableView;
}

- (IBAction)didTapShareButton:(id)sender {
    [self.output didTapShareButton];
}

- (void)collectionViewDidChangeContentSize:(UICollectionView *)collectionView
                                      cell:(UITableViewCell *)cell {
    [self.animator animateChangeCellSizeFromCollectionView:collectionView
                                                      cell:cell];
}

- (void)showVideoFromCacheWithLocalPath:(NSString *)localURL {
    NSURL *moveUrl = [NSURL fileURLWithPath:localURL];
    AVPlayer *player = [AVPlayer playerWithURL:moveUrl];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    [self.view addSubview: playerViewController.view];
    [self presentViewController:playerViewController animated:YES completion:nil];
}
@end
