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

#import "ReportLectureTableViewCellObject.h"
#import "ReportLectureTableViewCell.h"
#import "LecturePlainObject.h"
#import "UIColor+ConferencesPalette.h"
#import "SpeakerPlainObject.h"

@interface ReportLectureTableViewCellObject ()

@property (nonatomic, strong, readwrite) NSAttributedString *lectureTitle;
@property (nonatomic, strong, readwrite) NSString *company;
@property (nonatomic, strong, readwrite) NSAttributedString *tags;
@property (nonatomic, strong, readwrite) NSURL *imageURL;
@property (nonatomic, strong, readwrite) LecturePlainObject *lecture;
@property (nonatomic, copy, readwrite) NSAttributedString *speakerName;

@end

@implementation ReportLectureTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithLecture:(LecturePlainObject *)lecture
                 attributedName:(NSAttributedString *)attributedName
                           tags:(NSAttributedString *)tags
                    speakerName:(NSAttributedString *)speakerName
                       imageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _lectureTitle = attributedName;
        _imageURL = imageURL;
        _lecture = lecture;
        _company = lecture.speaker.company;
        _tags = tags;
        _speakerName = speakerName;
        
    }
    return self;
}

+ (instancetype)objectWithLecture:(LecturePlainObject *)lecture
                             tags:(NSAttributedString *)tags speakerName:(NSAttributedString *)highLightedSpeakerName
                  highlightedText:(NSAttributedString *)highlightedText {
    
    NSURL *lectureImageURL = [NSURL URLWithString:[lecture speaker].imageUrl];
    return [[self alloc] initWithLecture:lecture
                          attributedName:highlightedText
                                    tags:tags
                             speakerName:highLightedSpeakerName
                                imageURL:lectureImageURL];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [ReportLectureTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([ReportLectureTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
