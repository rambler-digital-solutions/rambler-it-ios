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

#import "LectureViewModelMapper.h"
#import "LectureViewModel.h"
#import "LectureMaterialModelObject.h"
#import "LectureMaterialViewModel.h"
#import "LecturePlainObject.h"
#import "LectureMaterialPlainObject.h"
#import "LectureMaterialCacheOperationType.h"

@implementation LectureViewModelMapper

- (LectureViewModel *)mapLectureViewModelFromLecturePlainObject:(LecturePlainObject *)lecture {
    LectureViewModel *model = [LectureViewModel new];
    model.lectureDescription = lecture.lectureDescription;
    model.lectureId = lecture.lectureId;
    model.name = lecture.name;
    model.speaker = lecture.speaker;
    model.lectureMaterials = [self mapLectureMaterials:lecture.lectureMaterials];
    model.tags = lecture.tags;
    return model;
}

- (LectureMaterialViewModel *)updateMaterialInLectureViewModel:(LectureViewModel *)lecture
                                               lectureMaterial:(LectureMaterialPlainObject *)plainMaterial
                                                 operationType:(LectureMaterialCacheOperationType)operationType
                                                       percent:(NSNumber *)percent {
    if (plainMaterial.link.length == 0) {
        return nil;
    }
    NSDictionary *flagsDownload = [self flagDownloadingWithTypeOperations];
    NSNumber *isDownloading = flagsDownload[@(operationType)];
    for (LectureMaterialViewModel *material in lecture.lectureMaterials) {
        if ([material.link isEqualToString:plainMaterial.link]) {
            material.isDownloading = isDownloading;
            material.percent = percent;
            material.localURL = plainMaterial.localURL;
            return material;
        }
    }
    return nil;
}

- (LectureMaterialPlainObject *)mapLectureMaterialPlainFromViewModel:(LectureMaterialViewModel *)lectureViewModel {
    LectureMaterialPlainObject *plain = [LectureMaterialPlainObject new];
    plain.lectureMaterialId = lectureViewModel.lectureMaterialId;
    plain.link = lectureViewModel.link;
    plain.localURL = lectureViewModel.localURL;
    plain.name = lectureViewModel.name;
    plain.type = lectureViewModel.type;
    return plain;
}

- (LectureMaterialViewModel *)mapLectureMaterialViewModelFromPlainObject:(LectureMaterialPlainObject *)plainMaterial {
    LectureMaterialViewModel *viewModel = [LectureMaterialViewModel new];
    viewModel.lectureMaterialId = plainMaterial.lectureMaterialId;
    viewModel.link = plainMaterial.link;
    viewModel.localURL = plainMaterial.localURL;
    viewModel.name = plainMaterial.name;
    viewModel.type = plainMaterial.type;
    return viewModel;
}

#pragma mark - Private methods

- (NSArray *)mapLectureMaterials:(NSSet *)lectureMaterials {
    NSArray *sortedMaterials = [self sortedLectureMaterials:lectureMaterials];
    NSArray *mappedMaterials = [self mapLectureMaterialViewModelFromPlainObjects:sortedMaterials];
    return mappedMaterials;
}

- (NSArray *)sortedLectureMaterials:(NSSet *)lectureMaterials{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:LectureMaterialModelObjectAttributes.name
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [lectureMaterials sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSArray *)mapLectureMaterialViewModelFromPlainObjects:(NSArray *)plainedObjects {
    NSMutableArray *mappedObjects = [NSMutableArray new];
    for (LectureMaterialPlainObject *material in plainedObjects) {
        LectureMaterialViewModel *viewModel = [LectureMaterialViewModel new];
        viewModel.lectureMaterialId = material.lectureMaterialId;
        viewModel.link = material.link;
        viewModel.localURL = material.localURL;
        viewModel.name = material.name;
        viewModel.type = material.type;
        viewModel.percent = @0;
        viewModel.isDownloading = @NO;
        [mappedObjects addObject:viewModel];
    }
    return mappedObjects;
}


- (NSDictionary *)flagDownloadingWithTypeOperations {
    return @{
             @(LectureMaterialStartDownloadType) : @YES,
             @(LectureMaterialDownloadType) : @YES,
             @(LectureMaterialEndDownloadType) : @NO,
             @(LectureMaterialRemoveType) : @NO
             };
}
@end
