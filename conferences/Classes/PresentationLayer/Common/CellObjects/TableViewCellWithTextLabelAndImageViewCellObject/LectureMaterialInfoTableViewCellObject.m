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

#import "LectureMaterialInfoTableViewCellObject.h"

#import "LectureMaterialInfoTableViewCell.h"
#import "LectureMaterialViewModel.h"

@interface LectureMaterialInfoTableViewCellObject ()

@property (nonatomic, strong, readwrite) LectureMaterialViewModel *lectureMaterial;
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) LectureMaterialType type;

@end

@implementation LectureMaterialInfoTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithLectureMaterialObject:(LectureMaterialViewModel *)lectureMaterialObject {
    self = [super init];
    if (self) {
        _lectureMaterial = lectureMaterialObject;
        _title = lectureMaterialObject.name;
        _type = [lectureMaterialObject.type integerValue];
    }
    return self;
}

+ (instancetype)objectWithLectureMaterialObject:(LectureMaterialViewModel *)lectureMaterialObject {
    return [[self alloc] initWithLectureMaterialObject:lectureMaterialObject];
}

# pragma mark - NICellObject methods

- (Class)cellClass {
    return [LectureMaterialInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([LectureMaterialInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
