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

#import "TagModuleTableViewCellObject.h"
#import "TagModuleTableViewCell.h"
#import "TagModuleOutput.h"
#import "TagModuleInput.h"
#import "TagMediatorInput.h"
#import "TagObjectDescriptor.h"

@implementation TagModuleTableViewCellObject

#pragma mark - NINibCellObject

- (instancetype)initWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                           mediatorInput:(id < TagMediatorInput > )mediatorInput{
    self = [super init];
    if (self) {
        _objectDescriptor = objectDescriptor;
        _mediatorInput = mediatorInput;
        _height = 44.0;
    }

    return self;
}

+ (instancetype)objectWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                             mediatorInput:(id <TagMediatorInput>)mediatorInput {
    return [[self alloc] initWithObjectDescriptor:objectDescriptor
                                    mediatorInput:mediatorInput];
}

- (UINib *)cellNib {
    NSString *nibName = NSStringFromClass([TagModuleTableViewCell class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [UINib nibWithNibName:nibName
                          bundle:bundle];
}

- (Class)cellClass {
    return [TagModuleTableViewCell class];
}

@end