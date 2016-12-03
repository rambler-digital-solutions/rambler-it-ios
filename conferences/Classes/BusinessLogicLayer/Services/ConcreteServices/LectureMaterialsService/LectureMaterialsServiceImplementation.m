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

#import "LectureMaterialsServiceImplementation.h"
#import "LectureMaterialPlainObject.h"
#import "LectureMaterialsHandler.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LectureMaterialModelObject.h"

@interface LectureMaterialsServiceImplementation ()

@property (nonatomic, strong) NSArray<LectureMaterialsHandler> *lectureMaterialsHandlers;

@end

@implementation LectureMaterialsServiceImplementation

- (instancetype)initWithLectureMaterialsHandlers:(NSArray<LectureMaterialsHandler> *)lectureMaterialsHandlers {
    self = [super init];
    
    if (self) {
        _lectureMaterialsHandlers = lectureMaterialsHandlers;
    }
    
    return self;
}

- (id)obtainFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial {
    id material = nil;
    for (id<LectureMaterialsHandler> handler in self.lectureMaterialsHandlers) {
        if ([handler canHandleLectureMaterial:lectureMaterial]) {
            material = [handler obtainFromCacheLectureMaterial:lectureMaterial];
            break;
        }
    }
    return material;
}

- (void)downloadToCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
                            completion:(LectureMaterialCompletionBlock)completionBlock {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    
    for (id<LectureMaterialsHandler> handler in self.lectureMaterialsHandlers) {
        if ([handler canHandleLectureMaterial:lectureMaterial]) {
            
            [handler downloadToCacheLectureMaterial:lectureMaterial
                                         completion:^(NSString *localUrl, NSError *error) {
                 [rootSavingContext performBlockAndWait:^{
                     NSString *attributeName = LectureMaterialModelObjectAttributes.lectureMaterialId;
                     LectureMaterialModelObject *modelMaterial = [LectureMaterialModelObject MR_findFirstByAttribute:attributeName
                                                                                                           withValue:lectureMaterial.lectureMaterialId];
                     modelMaterial.localURL = localUrl;
                     [rootSavingContext MR_saveToPersistentStoreAndWait];
                     completionBlock(localUrl, error);
                 }];
            }];
            break;
        }
    }
}

- (void)removeFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
                            completion:(LectureMaterialCompletionBlock)completionBlock {
    for (id<LectureMaterialsHandler> handler in self.lectureMaterialsHandlers) {
        if ([handler canHandleLectureMaterial:lectureMaterial]) {
            [handler removeFromCacheLectureMaterial:lectureMaterial
                                         completion:completionBlock];
            break;
        }
    }
}

@end
