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

#import "SpeakerInfoDataDisplayManager.h"
#import <Nimbus/NimbusModels.h>

#import "SpeakerPlainObject.h"
#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoCellObjectBuilder.h"
#import "SpeakerInfoSocialContactsCellObject.h"
#import "SpeakerInfoLectureCellObject.h"
#import "SocialNetworkType.h"
#import "EXTScope.h"

@interface SpeakerInfoDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) SpeakerPlainObject *speaker;

@end

@implementation SpeakerInfoDataDisplayManager

#pragma mark - Public methods

- (void)configureDataDisplayManagerWithSpeaker:(SpeakerPlainObject *)speaker {
    self.speaker = speaker;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

#pragma mark - DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        [self updateTableViewModelWithSpeaker:self.speaker];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView
                               withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupTableViewActions];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - Private methods

- (void)updateTableViewModelWithSpeaker:(SpeakerPlainObject *)speaker {
    NSArray *cellObjects = [self.cellObjectBuilder buildObjectsWithSpeaker:speaker];
    
    self.tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:cellObjects
                                                                  delegate:(id)[NICellFactory class]];
}

- (void)setupTableViewActions {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    
    @weakify(self);
    NIActionBlock socialContactActionBlock = ^BOOL(SpeakerInfoSocialContactsCellObject *object, UIViewController *controller, NSIndexPath *indexPath) {
        @strongify(self);
        SocialNetworkType type = object.networkType;
        
        if (type == SocialNetworkEmailType) {
            NSString *email = object.link;
            
            [self.delegate didTapEmailCellWithEmail:email];
            return YES;
        } else {
            NSURL *socialUrl = [NSURL URLWithString:object.link];
            
            [self.delegate didTapSocialMaterialCellWithUrl:socialUrl];
            return YES;
        }
    };
    [self.tableViewActions attachToClass:[SpeakerInfoSocialContactsCellObject class]
                                tapBlock:socialContactActionBlock];
    
    NIActionBlock lectureActionBlock = ^BOOL(SpeakerInfoLectureCellObject *object, UIViewController *controller, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapLectureCellWithLecture:object.lecture];
        return YES;
    };
    [self.tableViewActions attachToClass:[SpeakerInfoLectureCellObject class]
                                tapBlock:lectureActionBlock];
}

@end
