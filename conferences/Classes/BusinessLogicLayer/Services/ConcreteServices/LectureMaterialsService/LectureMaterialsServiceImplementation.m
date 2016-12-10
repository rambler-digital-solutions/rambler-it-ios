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
#import "LectureMaterialDownloadingDelegate.h"

@interface LectureMaterialsServiceImplementation ()

@property (nonatomic, copy) NSArray<LectureMaterialsHandler> *lectureMaterialsHandlers;

@end

@implementation LectureMaterialsServiceImplementation

- (instancetype)initWithLectureMaterialsHandlers:(NSArray<LectureMaterialsHandler> *)lectureMaterialsHandlers {
    self = [super init];
    
    if (self) {
        _lectureMaterialsHandlers = lectureMaterialsHandlers;
    }
    
    return self;
}

- (void)downloadToCacheLectureMaterialId:(NSString *)lectureMaterialId
                                delegate:(id<LectureMaterialDownloadingDelegate>)delegate {
    LectureMaterialModelObject *lectureMaterial = [self obtainFromCacheLectureMaterialWithId:lectureMaterialId];
    [self.lectureMaterialDownloadingManager registerDelegate:delegate
                                                      forURL:lectureMaterial.link];
    for (id<LectureMaterialsHandler> handler in self.lectureMaterialsHandlers) {
        if ([handler canHandleLectureMaterial:lectureMaterial]) {
            @weakify(self);
            [handler downloadToCacheLectureMaterial:lectureMaterial
                                           delegate:self.lectureMaterialDownloadingManager
                                         completion:^(NSString *localUrl, NSError *error) {
                @strongify(self);
                if (error) {
                    [delegate didEndDownloadingLectureMaterialWithError:error];
                }
                [self saveToPersistenStoreLectureMaterialWithID:lectureMaterial.lectureMaterialId
                                                       localURL:localUrl];
            }];
            break;
        }
    }
}

- (void)removeFromCacheLectureMaterialId:(NSString *)lectureMaterialId
                              completion:(LectureMaterialsCompletionBlock)completionBlock {
    LectureMaterialModelObject *lectureMaterial = [self obtainFromCacheLectureMaterialWithId:lectureMaterialId];
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
  forLectureMaterialId:(NSString *)lectureMaterialId {
    LectureMaterialModelObject *lectureMaterial = [self obtainFromCacheLectureMaterialWithId:lectureMaterialId];
    [self.lectureMaterialDownloadingManager updateDelegate:delegate
                                                    forURL:lectureMaterial.link];
}

#pragma mark - Private method

- (LectureMaterialModelObject *)obtainFromCacheLectureMaterialWithId:(NSString *)lectureMaterialId {
    LectureMaterialModelObject *modelObject = [LectureMaterialModelObject MR_findFirstByAttribute:LectureMaterialModelObjectAttributes.lectureMaterialId
                                                                                        withValue:lectureMaterialId];
    return modelObject;
}

- (void)saveToPersistenStoreLectureMaterialWithID:(NSString *)lectureMaterialId
                                         localURL:(NSString *)localURL {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    [context performBlockAndWait:^{
        NSString *nameAttribute = LectureMaterialModelObjectAttributes.lectureMaterialId;
        LectureMaterialModelObject *modelObject = [LectureMaterialModelObject MR_findFirstByAttribute:nameAttribute
                                                                                            withValue:lectureMaterialId
                                                                                            inContext:context];
        modelObject.localURL = localURL;
        [context MR_saveToPersistentStoreAndWait];
    }];
}
@end
