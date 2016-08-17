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

#import "TagCollectionViewCellObject.h"
#import "TagCollectionViewCell.h"
#import "TagCellDelegate.h"


@implementation TagCollectionViewCellObject

- (instancetype)initWithTagName:(NSString *)tagName
             enableRemoveButton:(BOOL)enableRemoveButton
                       delegate:(id <TagCellDelegate>)delegate {
    self = [super init];
    if (self) {
        _tagName = tagName;
        _enableRemoveButton = enableRemoveButton;
        _delegate = delegate;
    }

    return self;
}

- (UINib *)collectionViewCellNib {
    NSString *className = NSStringFromClass([TagCollectionViewCell class]);
    NSBundle *bundle = [NSBundle mainBundle];
    UINib *nib = [UINib nibWithNibName:className
                                bundle:bundle];
    return nib;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    TagCollectionViewCellObject *otherCellObject = other;

    return self.enableRemoveButton == otherCellObject.enableRemoveButton
            && [self.tagName isEqual:otherCellObject.tagName]
            && [self.delegate isEqual:otherCellObject.delegate];
}


@end