//
//  LectureViewModelMapper.m
//  Conferences
//
//  Created by k.zinovyev on 06.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureViewModelMapper.h"
#import "LectureViewModel.h"
#import "LectureMaterialModelObject.h"
#import "LectureMaterialViewModel.h"
#import "LecturePlainObject.h"
#import "LectureMaterialPlainObject.h"

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
                                                 isDownloading:(NSNumber *)isDownloading
                                                       percent:(NSNumber *)percent {
    if (plainMaterial.link.length == 0) {
        return nil;
    }
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
@end
