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

#import "EventGalleryDataDisplayManager.h"

#import "EventGalleryCellObjectFactory.h"
#import "EventGalleryEventCollectionViewCellObject.h"
#import "EventGalleryBackgroundColorAnimator.h"
#import "EventPlainObject.h"
#import "TechPlainObject.h"

#import "UIColor+Hex.h"
#import "UIColor+ConferencesPalette.h"
#import "EXTScope.h"
#import <Nimbus/NimbusCollections.h>

@interface EventGalleryDataDisplayManager () <UICollectionViewDelegateFlowLayout, EventGalleryBackgroundColorAnimatorDataSource>

@property (nonatomic, strong) NIMutableCollectionViewModel *collectionModel;
@property (nonatomic, strong) NICollectionViewActions *collectionActions;
@property (nonatomic, strong) EventGalleryCellObjectFactory *cellObjectFactory;
@property (nonatomic, weak) id<EventGalleryDataDisplayManagerDelegate> delegate;
@property (nonatomic, strong) EventGalleryBackgroundColorAnimator *animator;

@property (nonatomic, strong) NSArray *events;

@end

@implementation EventGalleryDataDisplayManager

#pragma mark - Initialization

- (instancetype)initWithCellObjectFactory:(EventGalleryCellObjectFactory *)cellObjectFactory
                                 animator:(EventGalleryBackgroundColorAnimator *)animator
                                 delegate:(id<EventGalleryDataDisplayManagerDelegate>)delegate {
    self = [super init];
    if (self) {
        _cellObjectFactory = cellObjectFactory;
        _delegate = delegate;
        _animator = animator;
    }
    return self;
}

#pragma mark - Public methods

- (id<UICollectionViewDataSource>)dataSourceForCollectionView:(UICollectionView *)collectionView {
    
    self.collectionModel = [[NIMutableCollectionViewModel alloc] initWithSectionedArray:@[@""]
                                                                               delegate:(id)[NICollectionViewCellFactory class]];
    return self.collectionModel;
}

- (id<UICollectionViewDelegate>)delegateForCollectionView:(UICollectionView *)collectionView {
    if (!self.collectionActions) {
        [self setupCollectionActions];
    }
    return self;
}

- (void)updateDataSourceWithEvents:(NSArray *)events {
    self.events = events;
    [self.collectionModel removeSectionAtIndex:0];
    [self.collectionModel addSectionWithTitle:@""];
    
    NSArray *cellObjects = [self.cellObjectFactory createCellObjectsWithEvents:events];
    [self.collectionModel addObjectsFromArray:cellObjects];
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.collectionActions collectionView:collectionView
                         didSelectItemAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.animator animateColorChangeWithScrollOffset:scrollView.contentOffset.x];
}

#pragma mark - <EventGalleryBackgroundColorAnimatorDataSource>

- (UIColor *)obtainColorForPageWithNumber:(NSUInteger)pageNumber {
    if (pageNumber == self.events.count) {
        // That's the case for "More events" card
        UIColor *moreEventsColor = [UIColor rcf_lightGrayColor];
        return moreEventsColor;
    }
    EventPlainObject *event = self.events[pageNumber];
    NSString *colorString = event.tech.color;
    UIColor *eventColor = [UIColor colorFromHexString:colorString];
    return eventColor;
}


#pragma mark - Private methods

- (void)setupCollectionActions {
    self.collectionActions = [[NICollectionViewActions alloc] initWithTarget:self];
    
    @weakify(self);
    NIActionBlock announcementTapActionBlock = ^BOOL(EventGalleryEventCollectionViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate didTapEventAnnouncementCellWithEvent:object.event];
        return YES;
    };
    
    [self.collectionActions attachToClass:[EventGalleryEventCollectionViewCellObject class]
                                tapBlock:announcementTapActionBlock];
}

@end
