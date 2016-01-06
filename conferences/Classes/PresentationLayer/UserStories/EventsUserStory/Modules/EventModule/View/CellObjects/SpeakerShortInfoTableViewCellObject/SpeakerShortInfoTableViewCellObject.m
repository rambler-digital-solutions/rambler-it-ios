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

#import "SpeakerShortInfoTableViewCellObject.h"
#import "SpeakerShortInfoTableViewCell.h"
#import "PlainSpeaker.h"

@interface SpeakerShortInfoTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *speakerName;
@property (strong, nonatomic, readwrite) NSString *speakerCompanyName;
@property (strong, nonatomic, readwrite) NSURL *speakerImageLink;
@property (assign, nonatomic, readwrite) SpeakerShortInfoTableViewCellSize cellSize;

@end

@implementation SpeakerShortInfoTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithSpeaker:(PlainSpeaker *)speaker cellSize:(SpeakerShortInfoTableViewCellSize)cellSize {
    self = [super init];
    if (self) {
        _speakerName = speaker.name;
        _speakerCompanyName = speaker.companyName;
        _speakerImageLink = speaker.pictureLink;
        _cellSize = cellSize;
    }
    return self;
}

+ (instancetype)objectWithSpeaker:(PlainSpeaker *)speaker cellSize:(SpeakerShortInfoTableViewCellSize)cellSize {
    return [[self alloc] initWithSpeaker:speaker cellSize:cellSize];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [SpeakerShortInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([SpeakerShortInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
