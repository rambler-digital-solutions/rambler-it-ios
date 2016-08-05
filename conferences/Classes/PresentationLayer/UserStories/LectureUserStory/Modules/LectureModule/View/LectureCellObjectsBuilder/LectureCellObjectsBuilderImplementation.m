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

#import "LectureCellObjectsBuilderImplementation.h"

#import "LecturePlainObject.h"
#import "LectureModelObject.h"
#import "LocalizedStrings.h"

#import "LectureMaterialTitleTableViewCellObject.h"
#import "LectureDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "LectureMaterialTitleTableViewCellObject.h"
#import "LectureMaterialInfoTableViewCellObject.h"
#import "VideoRecordTableViewCellObject.h"

#import "TagObjectDescriptor.h"
#import "TagModuleTableViewCellObject.h"
#import "TagShowMediator.h"

static NSString *const kPresentationImageName = @"ic-presentation";
static NSString *const kArticleImageName = @"ic-article";
static NSString *const kCodeGithubImageName = @"ic-github";

@implementation LectureCellObjectsBuilderImplementation

- (NSArray *)cellObjectsForLecture:(LecturePlainObject *)lecture {
    LectureInfoTableViewCellObject *lectureDescriptionCellObject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
    
    NSString *videoRecordTextTitle = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(VideoRecordTableViewCellTitle, nil), @"(32:12)"];
    LectureMaterialTitleTableViewCellObject *videoRecordTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:videoRecordTextTitle];
    
    VideoRecordTableViewCellObject *videoRecorTableViewCellObject = [VideoRecordTableViewCellObject new];
    
    LectureMaterialTitleTableViewCellObject *materialsTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:NSLocalizedString(LectureMaterialsTableViewCellTitle, nil)];
    
    LectureMaterialTitleTableViewCellObject *additionalTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:NSLocalizedString(AdditionInformationTableViewCellTitle, nil)];
    
    UIImage *presentationImage = [UIImage imageNamed:kPresentationImageName];
    LectureMaterialInfoTableViewCellObject *presentationTextImageLabelCellObject = [LectureMaterialInfoTableViewCellObject objectWithText:NSLocalizedString(LecturePresentationTableViewCellTitle, nil) andImage:presentationImage];
    
    UIImage *articleImage = [UIImage imageNamed:kArticleImageName];
    LectureMaterialInfoTableViewCellObject *articlesTextImageLabelCellObject = [LectureMaterialInfoTableViewCellObject objectWithText:NSLocalizedString(LectureArticlesTableViewCellTitle, nil) andImage:articleImage];
    
    UIImage *codeGithubImage = [UIImage imageNamed:kCodeGithubImageName];
    LectureMaterialInfoTableViewCellObject *codeGithubTextLabelCellObject = [LectureMaterialInfoTableViewCellObject objectWithText:NSLocalizedString(LectureCodeGithubTableViewCellTitle, nil) andImage:codeGithubImage];
    
    TagModuleTableViewCellObject *tagCellObject;
    if (lecture.tags.count > 0) {
        TagObjectDescriptor *objectDescriptor = [[TagObjectDescriptor alloc] initWithObjectName:NSStringFromClass([LectureModelObject class])
                                                                                        idValue:lecture.lectureId];
        tagCellObject = [TagModuleTableViewCellObject objectWithObjectDescriptor:objectDescriptor
                                                                   mediatorInput:[TagShowMediator new]];
    }
    
    return @[lectureDescriptionCellObject, videoRecordTextLabelCellObject, videoRecorTableViewCellObject, materialsTextLabelCellObject, presentationTextImageLabelCellObject, articlesTextImageLabelCellObject, additionalTextLabelCellObject, codeGithubTextLabelCellObject, tagCellObject];
}

@end
