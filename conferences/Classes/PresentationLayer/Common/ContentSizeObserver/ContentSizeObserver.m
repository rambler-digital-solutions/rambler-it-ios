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