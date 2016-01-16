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

#import "CDResponderTableViewCell.h"
#import "UIView+CDResponder.h"
#import "RCMResignFirstResponderHandler.h"

@interface CDResponderTableViewCell ()

@end

@implementation CDResponderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupInit];
}

- (void)setupInit {
    
    // Добавление UITapGestureRecognizer
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(recognizeTapGesture:)];
    [self addGestureRecognizer:self.tapRecognizer];
}

- (BOOL)resignFirstResponder {
    /**
     *  @author Egor Tolstoy
     *
     *  Уведомляем контроллер о том, что у UITableViewCell был дернут метод resignFirstResponder, дешево и сердито.
     *  В дальнейшем прикрутим реализацию через proxyObject
     */
    [[UIApplication sharedApplication] sendAction:@selector(tableViewCellDidResignFirstResponder:)
                                               to:nil
                                             from:self
                                         forEvent:nil];
    return [super resignFirstResponder];
}

#pragma mark - Публичные методы

- (void)recognizeTapGesture:(UITapGestureRecognizer *)gesture {
    
    NSArray *responderClasses = [self responderClasses];
    
    /**
     *  @author Vadim Smal
     *
     *  Осуществляем поиск всех UIResponder,
     *  которые отвечают на селектор canBecomeFirstResponder YES
     *  и класс содержится в responderClasses
     *
     */
    
    NSArray *responders = [self respondersForSelector:@selector(canBecomeFirstResponder)
                                     responderClasses:responderClasses
                                   resultExpectedBlock:^BOOL(void *value) {
                                       return (BOOL)value;
                            }];
    
    /**
     *  @author Vadim Smal
     *
     *  Считаем дистанцию до всех респондеров
     * и выбираем ближайший
     */
    
    UIResponder *nearestResponder;
    CGFloat nearestResponderDistance = CGFLOAT_MAX;
    
    for (UIView *view in responders) {
        
        CGPoint location = [gesture locationInView:view];
        CGFloat distance = [self distanceForLocation:location];
        
        if (!nearestResponder) {
            
            nearestResponder = view;
            nearestResponderDistance = distance;
            
        } else if (distance < nearestResponderDistance) {
            
            nearestResponder = view;
            nearestResponderDistance = distance;
            
        }
    }

    [nearestResponder becomeFirstResponder];
}

- (NSArray *)responderClasses {
    return @[
             [UITextField class],
             [UITextView class],
             [UIWebView class]
            ];
}

#pragma mark - Приватные методы

- (CGFloat)distanceForLocation:(CGPoint)location {
    
    CGFloat x = fabs(location.x);
    CGFloat y = fabs(location.y);
    
    CGFloat xPow2 = pow(x, 2);
    CGFloat yPow2 = pow(y, 2);
    
    CGFloat distance = sqrtf(xPow2 + yPow2);
    
    return distance;
}

@end
