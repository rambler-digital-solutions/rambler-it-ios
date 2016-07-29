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

#import <UIKit/UIKit.h>
#import "EventViewInput.h"
#import "EventTableViewCellActionProtocol.h"
#import "EventDataDisplayManager.h"

@protocol EventViewOutput;
@protocol EventHeaderModuleInput;
@class EventDataDisplayManager;
@class EventViewAnimator;

@interface EventViewController : UIViewController <EventViewInput, EventTableViewCellActionProtocol, EventDataDisplayManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView <EventHeaderModuleInput> *headerView;
@property (strong, nonatomic) IBOutlet EventViewAnimator *eventViewAnimator;

@property (nonatomic, strong) id<EventViewOutput> output;
@property (strong, nonatomic) EventDataDisplayManager *dataDisplayManager;

#pragma mark - IBActions

- (IBAction)didTapShareButton:(UIBarButtonItem *)sender;

@end

