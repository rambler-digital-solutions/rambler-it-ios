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

#import "SpeakerInfoViewController.h"
#import "SpeakerInfoViewOutput.h"
#import "SpeakerInfoDataDisplayManager.h"
#import "SpeakerShortInfoModuleInput.h"
#import "UINavigationBar+States.h"

static CGFloat TableViewEstimatedRowHeight = 44.0f;

@implementation SpeakerInfoViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
}

#pragma mark - SpeakerInfoViewInput

- (void)setupViewWithSpeaker:(SpeakerPlainObject *)speaker {
    [self setupViewInitialState];
    
    [self.dataDisplayManager configureDataDisplayManagerWithSpeaker:speaker];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
    self.tableView.estimatedRowHeight = TableViewEstimatedRowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setupHeaderViewWithSpeaker:speaker];
}

#pragma mark - <SpeakerInfoDataDisplayManagerDelegate>

- (void)didTapSocialMaterialCellWithUrl:(NSURL *)socialUrl {
    [self.output didTriggerSocialNetworkTapEventWithUrl:socialUrl];
}

- (void)didTapLectureCellWithLecture:(LecturePlainObject *)lecture {
    [self.output didTriggerLectureTapEventWithLecture:lecture];
}

#pragma mark - Private methods

- (void)setupHeaderViewWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.speakerShortInfoView configureModuleWithSpeaker:speaker
                                              andViewSize:SpeakerShortInfoViewBigSize];
    
    self.tableView.tableHeaderView = nil;
    CGRect frame = [self calculateFrameForHeaderView];
    self.speakerShortInfoView.frame = frame;
    self.tableView.tableHeaderView = self.speakerShortInfoView;
}

- (void)setupViewInitialState {
    [self.navigationController.navigationBar rcf_becomeTransparent];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.hidden = NO;
}

- (CGRect)calculateFrameForHeaderView {
    CGRect frame = self.speakerShortInfoView.frame;
    frame.size.width = self.view.bounds.size.width;
    frame.size = [self.speakerShortInfoView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return frame;
}

#pragma mark - IBActions

- (IBAction)didTapShareButton:(id)sender {
    [self.output didTriggerShareButtonTapEvent];
}

@end