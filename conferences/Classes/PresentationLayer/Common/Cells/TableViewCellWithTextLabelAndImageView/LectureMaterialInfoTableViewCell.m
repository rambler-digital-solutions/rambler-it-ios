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

#import "LectureMaterialInfoTableViewCell.h"
#import "LectureMaterialInfoTableViewCellObject.h"

static CGFloat const TableViewCellWithTextLabelAndImageViewHeight = 40.0f;
static NSString *const kPresentationImageName = @"ic-presentation";
static NSString *const kArticleImageName = @"ic-article";
static NSString *const kCodeGithubImageName = @"ic-github";
static NSString *const kVideoImageName = @"video-material-icon";
static NSString *const kOtherImageName = @"unspecified-material-icon";

@interface LectureMaterialInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LectureMaterialInfoTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(LectureMaterialInfoTableViewCellObject *)object {
    UIImage *materialImage = [self obtainImageForMaterialType:object.type];
    
    self.iconImageView.image = materialImage;
    self.label.text = object.title;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return TableViewCellWithTextLabelAndImageViewHeight;
}

#pragma mark - Private methods

- (UIImage *)obtainImageForMaterialType:(LectureMaterialType)type {
    NSDictionary *mappingDictionary = [self materialTypeToImageNameMappingDictionary];
    NSString *imageName = mappingDictionary[@(type)];
    return [UIImage imageNamed:imageName];
}

- (NSDictionary *)materialTypeToImageNameMappingDictionary {
    NSDictionary *mappingDictionary;
    if (mappingDictionary) {
        return mappingDictionary;
    }
    mappingDictionary = @{
                          @(LectureMaterialVideoType) : kVideoImageName,
                          @(LectureMaterialPresentationType) : kPresentationImageName,
                          @(LectureMaterialRepoType) : kCodeGithubImageName,
                          @(LectureMaterialArticleType) : kArticleImageName,
                          @(LectureMaterialOtherType) : kOtherImageName
                          };
    return mappingDictionary;
}

@end
