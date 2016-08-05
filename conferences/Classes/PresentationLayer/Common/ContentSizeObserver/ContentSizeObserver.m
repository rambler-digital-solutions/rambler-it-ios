//
// ContentSizeObserver.m
// LiveJournal
// 
// Created by Golovko Mikhail on 25/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ContentSizeObserver.h"


@implementation ContentSizeObserver

- (void)setObserverView:(UIView *)observerView {
    [self unsubscribeChangeContentSize];
    _observerView = observerView;
    [self subscribeChangeContentSize];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqual:NSStringFromSelector(@selector(contentSize))]) {
        CGSize oldSize = [change[NSKeyValueChangeOldKey] CGSizeValue];
        CGSize newSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
        // Проверяем, что размер поменялся, так как KVO будет вызваться каждый раз, когда сработал селектор.
        if (!CGSizeEqualToSize(oldSize, newSize)) {
            [self.delegate contentSizeObserver:self
                      viewDidChangeContentSize:self.observerView];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

- (void)dealloc {
    [self unsubscribeChangeContentSize];
}

#pragma mark - Дополнительные методы

- (void)subscribeChangeContentSize {
    [self.observerView addObserver:self
                        forKeyPath:NSStringFromSelector(@selector(contentSize))
                           options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                           context:0];
}

- (void)unsubscribeChangeContentSize {
    if (!self.observerView) {
        return;
    }

    [self.observerView removeObserver:self
                           forKeyPath:NSStringFromSelector(@selector(contentSize))];
}


@end