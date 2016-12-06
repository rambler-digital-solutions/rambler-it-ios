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
#import "LectureMaterialDownloadingManager.h"
#import "EXTScope.h"

@protocol LectureMaterialDownloadingDelegate;

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
                              delegate:(id<LectureMaterialDownloadingDelegate>)delegate {
    [self.lectureMaterialDownloadingManager registerDelegate:delegate
                                                      forURL:lectureMaterial.link];
    for (id<LectureMaterialsHandler> handler in self.lectureMaterialsHandlers) {
        if ([handler canHandleLectureMaterial:lectureMaterial]) {
            @weakify(self);
            [handler downloadToCacheLectureMaterial:lectureMaterial
                                           delegate:self.lectureMaterialDownloadingManager
                                         completion:^(NSString *localUrl, NSError *error) {
                 @strongify(self);
                 [self saveToPersistenStoreLectureMaterialWithID:lectureMaterial.lectureMaterialId
                                                        localURL:localUrl];
            }];
            break;
        }
    }
}

- (void)removeFromCacheLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial
                            completion:(LectureMaterialServiceCompletionBlock)completionBlock {
    for (id<LectureMaterialsHandler> handler in self.lectureMaterialsHandlers) {
        if ([handler canHandleLectureMaterial:lectureMaterial]) {
            @weakify(self);
            [handler removeFromCacheLectureMaterial:lectureMaterial
                                         completion:^(NSString *localUrl, NSError *error) {
                      @strongify(self);
                      [self saveToPersistenStoreLectureMaterialWithID:lectureMaterial.lectureMaterialId
                                                             localURL:localUrl];
                    if (completionBlock) {
                        completionBlock(error);
                    }
                                         }];
            break;
        }
    }
}

- (void)updateDelegate:(id<LectureMaterialDownloadingDelegate>)delegate
    forLectureMaterial:(LectureMaterialPlainObject *)lectureMaterial {
    [self.lectureMaterialDownloadingManager updateDelegate:delegate
                                                    forURL:lectureMaterial.link];
}

#pragma mark - Private methods

- (void)saveToPersistenStoreLectureMaterialWithID:(NSString *)lectureMaterialId
                                         localURL:(NSString *)localURL {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_defaultContext];
    [rootSavingContext performBlockAndWait:^{
        NSString *nameAttribute = LectureMaterialModelObjectAttributes.lectureMaterialId;
        LectureMaterialModelObject *modelObject = [LectureMaterialModelObject MR_findFirstByAttribute:nameAttribute
                                                                                            withValue:lectureMaterialId
                                                                                            inContext:rootSavingContext];
        modelObject.localURL = localURL;
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
}
@end
