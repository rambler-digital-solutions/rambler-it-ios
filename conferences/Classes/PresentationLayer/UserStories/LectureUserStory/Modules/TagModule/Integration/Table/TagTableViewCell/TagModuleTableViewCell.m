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

#import "TagModuleTableViewCell.h"
#import "TagModuleTableViewCellObject.h"
#import "TagObjectDescriptor.h"
#import <CrutchKit/CDProxying.h>
#import "TagMediatorInput.h"
#import "TagModuleViewConstants.h"

@interface TagModuleTableViewCell ()

@property (nonatomic, strong) TagModuleTableViewCellObject *cellObject;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingConstraintCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraintCollectionView;

@end

@implementation TagModuleTableViewCell

@synthesize isConfigured = _isConfigured;

#pragma mark - Методы NICell

- (BOOL)shouldUpdateCellWithObject:(TagModuleTableViewCellObject *)object {

    if ([self.cellObject isEqual:object]) {
        return NO;
    }

    self.cellObject = object;
    self.topConstraintCollectionView.constant = kVerticalContentSpacing;
    self.bottomConstraintCollectionView.constant = kVerticalContentSpacing;
    self.trailingConstraintCollectionView.constant = kRightContentSpacing;
    self.leadingConstraintCollectionView.constant = kLeftContentSpacing;
    
    self.cellObject.height = [self calculateHeightTableViewCellWithCellObject:object
                                                               tagModuleInput:self.tagCollectionView];
    
    [object.mediatorInput configureWithObjectDescriptor:object.objectDescriptor
                                         tagModuleInput:self.tagCollectionView];
    
    return YES;
}


+ (CGFloat)heightForObject:(TagModuleTableViewCellObject *)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return object.height;
}

#pragma mark - private

- (CGFloat)calculateHeightTableViewCellWithCellObject:(TagModuleTableViewCellObject *)object
                                       tagModuleInput:(id <TagModuleInput>)moduleInput{
    CGFloat heightTagModuleView = [object.mediatorInput obtainHeightTagModuleViewWithObjectDescriptor:self.cellObject.objectDescriptor
                                                                                       tagModuleInput:moduleInput];
     return heightTagModuleView + kVerticalContentSpacing * 2;
}

@end