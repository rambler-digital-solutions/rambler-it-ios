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

#import "TagModuleTableViewCell.h"
#import "TagModuleTableViewCellObject.h"
#import "TagEditMediator.h"
#import "TagObjectDescriptor.h"
#import <CrutchKit/CDProxying.h>

@interface TagModuleTableViewCell ()

@property (nonatomic, strong) TagModuleTableViewCellObject *cellObject;

@end

@implementation TagModuleTableViewCell

@synthesize isConfigured = _isConfigured;

- (void)awakeFromNib {
    [super awakeFromNib];
    /**
     @author Vadim Smal
     
     Если при открытие экрана таблица не видна (из за большого хэдера на iPhone 4),
     ячейка при не правильного размера - из за этого collectionView внутри таблицы
     неправильно лейаутится (contentSizeObserver:viewDidChangeContentSize:) и обновляется.
     Если это делать когда показалась, будут различные сайд эффекты. (скролинг, видимость анимации расширенияи т.д.)
     + тот же механизм используется при написание поста.
     
     Поэтому мы задаем правильный размер UICollectionView заранее
     */
    self.collectionViewWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width - (self.collectionViewLeadingConstraint.constant * 2);
}

#pragma mark - Методы NICell

- (BOOL)shouldUpdateCellWithObject:(TagModuleTableViewCellObject *)object {

    if ([self.cellObject isEqual:object]) {
        return NO;
    }

    self.sizeObserver.observerView = self.tagCollectionView;

    self.cellObject = object;

    [object.mediatorInput configureWithObjectDescriptor:self.cellObject.objectDescriptor
                                         tagModuleInput:self.tagCollectionView];

    return YES;
}

#pragma mark - Методы ContentSizeObserverDelegate

- (void)contentSizeObserver:(ContentSizeObserver *)observer
   viewDidChangeContentSize:(UIView *)view {
    
    /**
     @author Golovko Mikhail
     
     На iOS 8 есть баг, когда меняем размер collectionView, она не пересчитывает положение ячеек.
     */
    [self.tagCollectionView.collectionViewLayout invalidateLayout];
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    if (self.cellObject.height == height) {
        return;
    }
    self.cellObject.height = height;
    id <TagTableViewCellDelegate> proxy = [[self cd_proxyForProtocol:@protocol(TagTableViewCellDelegate)] unwrap];
    [proxy collectionViewDidChangeContentSize:self.tagCollectionView
                                         cell:self];
}

+ (CGFloat)heightForObject:(TagModuleTableViewCellObject *)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return object.height;
}

@end