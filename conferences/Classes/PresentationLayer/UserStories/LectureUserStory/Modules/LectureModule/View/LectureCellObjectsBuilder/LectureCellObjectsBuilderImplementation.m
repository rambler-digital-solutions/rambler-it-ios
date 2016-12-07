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

#import "LectureViewModel.h"
#import "LectureModelObject.h"
#import "LectureMaterialViewModel.h"
#import "LocalizedStrings.h"

#import "LectureMaterialTitleTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "LectureMaterialTitleTableViewCellObject.h"
#import "LectureMaterialInfoTableViewCellObject.h"
#import "VideoRecordTableViewCellObjectMapper.h"
#import "LectureInfoTableViewCellObjectMapper.h"

#import "TagModuleTableViewCellObject.h"
#import "LectureMaterialType.h"
#import "TagObjectDescriptor.h"
#import "TagShowMediator.h"


@implementation LectureCellObjectsBuilderImplementation

- (NSArray *)cellObjectsForLecture:(LectureViewModel *)lecture {
    NSMutableArray *cellObjects = [NSMutableArray new];
    
    // Lecture description block
    id lectureDescriptionCellObject = [self.lectureInfoCellObjectMapper lectureInfoTableViewCellObjectWithLecture:lecture
                                                                                              continueReadingFlag:NO];
    [cellObjects addObject:lectureDescriptionCellObject];
    
    // Lecture tags block
    TagModuleTableViewCellObject *tagCellObject;
    if (lecture.tags.count > 0) {
        TagObjectDescriptor *objectDescriptor = [[TagObjectDescriptor alloc] initWithObjectName:NSStringFromClass([LectureModelObject class])
                                                                                        idValue:lecture.lectureId];
        tagCellObject = [TagModuleTableViewCellObject objectWithObjectDescriptor:objectDescriptor
                                                                   mediatorInput:[TagShowMediator new]];
        [cellObjects addObject:tagCellObject];
    }
    
    // Video preview block
    LectureMaterialViewModel *videoMaterial = [self videoMaterialForLecture:lecture];
    if (videoMaterial.link) {
        NSString *videoRecordTextTitle = NSLocalizedString(VideoRecordTableViewCellTitle, nil);
        LectureMaterialTitleTableViewCellObject *videoRecordTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:videoRecordTextTitle];
        [cellObjects addObject:videoRecordTextLabelCellObject];
        
        id videoCellObject = [self.videoCellObjectMapper videoRecordCellObjectWithVideoMaterial:videoMaterial];
        [cellObjects addObject:videoCellObject];
    }
    
    // Lecture materials block
    NSMutableArray *mainMaterials = [NSMutableArray new];
    NSMutableArray *otherMaterials = [NSMutableArray new];
    for (LectureMaterialViewModel *material in lecture.lectureMaterials) {
        if ([material.type integerValue] == LectureMaterialVideoType ||
            [material.type integerValue] == LectureMaterialPresentationType ||
            [material.type integerValue] == LectureMaterialArticleType) {
            [mainMaterials addObject:material];
        } else {
            [otherMaterials addObject:material];
        }
    }
    
    // Main lecture materials block
    NSArray *mainMaterialCellObjects = [self generateMaterialsSectionCellObjectsWithMaterials:mainMaterials
                                                                                 sectionTitle:NSLocalizedString(LectureMaterialsTableViewCellTitle, nil)];
    [cellObjects addObjectsFromArray:mainMaterialCellObjects];
    
    // Other lecture materials block
    NSArray *otherMaterialCellObjects = [self generateMaterialsSectionCellObjectsWithMaterials:otherMaterials
                                                                                  sectionTitle:NSLocalizedString(AdditionInformationTableViewCellTitle, nil)];
    [cellObjects addObjectsFromArray:otherMaterialCellObjects];

    return cellObjects;
}

- (VideoRecordTableViewCellObject *)videoCellObjectForVideoMaterial:(LectureMaterialViewModel *)viewModel {
    VideoRecordTableViewCellObject *videoCellObject = [self.videoCellObjectMapper videoRecordCellObjectWithVideoMaterial:viewModel];
    return videoCellObject;
}
#pragma mark - Private methods

- (LectureMaterialViewModel *)videoMaterialForLecture:(LectureViewModel *)lecture {
    for (LectureMaterialViewModel *material in lecture.lectureMaterials) {
        if ([material.type integerValue] == LectureMaterialVideoType) {
            return material;
        }
    }
    return nil;
}

- (NSArray *)generateMaterialsSectionCellObjectsWithMaterials:(NSArray *)materials
                                                 sectionTitle:(NSString *)sectionTitle {
    NSMutableArray *cellObjects = [NSMutableArray new];
    if (materials.count > 0) {
        LectureMaterialTitleTableViewCellObject *materialsTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:sectionTitle];
        [cellObjects addObject:materialsTextLabelCellObject];
        for (LectureMaterialViewModel *material in materials) {
            LectureMaterialInfoTableViewCellObject *cellObject = [LectureMaterialInfoTableViewCellObject objectWithLectureMaterialObject:material];
            [cellObjects addObject:cellObject];
        }
    }
    return [cellObjects copy];
}

@end
