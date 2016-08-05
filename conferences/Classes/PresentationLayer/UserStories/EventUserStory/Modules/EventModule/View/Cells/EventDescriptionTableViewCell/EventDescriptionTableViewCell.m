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

#import "EventDescriptionTableViewCell.h"
#import "EventDescriptionTableViewCellObject.h"
#import "EventTableViewCellActionProtocol.h"
#import "EventDescriptionTableViewCellActionProtocol.h"
#import "Extensions/UIResponder+CDProxying/UIResponder+CDProxying.h"

@interface EventDescriptionTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *eventDescription;

@property (weak, nonatomic) id <EventDescriptionTableViewCellActionProtocol> actionProxy;

@end

@implementation EventDescriptionTableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<EventDescriptionTableViewCellActionProtocol>)[self cd_proxyForProtocol:@protocol(EventTableViewCellActionProtocol)];
}

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(EventDescriptionTableViewCellObject *)object {
    self.eventDescription.text = object.eventDescription;
    [self.eventDescription setBackgroundColor:[UIColor whiteColor]];
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return UITableViewAutomaticDimension;
}

#pragma mark - IBActions

- (IBAction)didTapReadMoreButton:(UIButton *)sender {
    [self.actionProxy didTapReadMoreEventDescriptionButton];
}

@end
