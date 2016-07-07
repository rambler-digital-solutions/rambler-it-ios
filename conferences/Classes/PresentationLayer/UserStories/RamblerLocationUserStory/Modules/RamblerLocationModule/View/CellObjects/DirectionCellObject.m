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

#import "DirectionCellObject.h"

#import "DirectionObject.h"
#import "DirectionCollectionViewCell.h"

@interface DirectionCellObject ()

@property (nonatomic, copy, readwrite) NSString *directionTitle;
@property (nonatomic, copy, readwrite) NSString *directionDescription;

@end

@implementation DirectionCellObject

#pragma mark - Initialization

+ (instancetype)objectWithDirection:(DirectionObject *)direction {
    return [[[self class] alloc] initWithDirection:direction];
}

- (instancetype)initWithDirection:(DirectionObject *)direction {
    self = [super init];
    if (self) {
        _directionTitle = direction.directionTitle;
        _directionDescription = direction.directionDescription;
    }
    return self;
}

#pragma mark - <NICollectionViewCellObject>

- (Class)collectionViewCellClass {
    return [DirectionCollectionViewCell class];
}

@end
