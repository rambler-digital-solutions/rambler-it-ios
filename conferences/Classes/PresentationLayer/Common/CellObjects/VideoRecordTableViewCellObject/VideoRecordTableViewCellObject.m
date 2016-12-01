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

#import "VideoRecordTableViewCellObject.h"
#import "VideoRecordTableViewCell.h"

@interface VideoRecordTableViewCell ()

@property (nonatomic, strong, readwrite) NSURL *previewImageUrl;
@property (nonatomic, strong, readwrite) LectureMaterialPlainObject *videoMaterial;
@property (nonatomic, assign, readwrite) BOOL isVideoCached;
@property (nonatomic, assign, readwrite) BOOL isVideoDownloading;

@end

@implementation VideoRecordTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithPreviewImageUrl:(NSURL *)previewImageUrl
                          isVideoCached:(BOOL)isVideoCached
                     isVideoDownloading:(BOOL)isVideoDownloading
                          videoMaterial:(LectureMaterialPlainObject *)videoMaterial {
    self = [super init];
    if (self) {
        _previewImageUrl = previewImageUrl;
        _videoMaterial = videoMaterial;
        _isVideoDownloading = isVideoDownloading;
        _isVideoCached = isVideoCached;
    }
    return self;
}

+ (instancetype)objectWithPreviewImageUrl:(NSURL *)previewImageUrl
                            isVideoCached:(BOOL)isVideoCached
                       isVideoDownloading:(BOOL)isVideoDownloading
                            videoMaterial:(LectureMaterialPlainObject *)videoMaterial {
    return [[self alloc] initWithPreviewImageUrl:previewImageUrl
                                   isVideoCached:isVideoCached
                              isVideoDownloading:isVideoDownloading
                                   videoMaterial:videoMaterial];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [VideoRecordTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([VideoRecordTableViewCell class])
                          bundle:[NSBundle mainBundle]];
}

@end
