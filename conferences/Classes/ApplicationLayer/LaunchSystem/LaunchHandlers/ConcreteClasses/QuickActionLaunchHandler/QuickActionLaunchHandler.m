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

#import "QuickActionLaunchHandler.h"

#import "ObjectTransformer.h"
#import "LaunchRouter.h"
#import "QuickActionConstants.h"

@interface QuickActionLaunchHandler ()

@property (nonatomic, strong) id<ObjectTransformer> objectTransformer;
@property (nonatomic, strong) id<LaunchRouter> launchRouter;
@property (nonatomic, copy) NSString *quickActionItemType;

@end

@implementation QuickActionLaunchHandler

#pragma mark - Initialization

- (instancetype)initWithObjectTransformer:(id<ObjectTransformer>)objectTransformer
                     launchRouter:(id<LaunchRouter>)launchRouter
                      quickActionItemType:(NSString *)quickActionItemType {
    self = [super init];
    if (self) {
        _objectTransformer = objectTransformer;
        _launchRouter = launchRouter;
        _quickActionItemType = quickActionItemType;
    }
    return self;
}

#pragma mark - <LaunchHandler>

- (BOOL)canHandleLaunchWithActivity:(NSUserActivity *)activity {
    NSString *itemIdentifier = [self itemIdentifierFromActivity:activity];
    if (itemIdentifier) {
        return [self.objectTransformer isCorrectIdentifier:itemIdentifier];
    }
    
    BOOL isCorrectType = [self.quickActionItemType isEqualToString:activity.activityType];
    return isCorrectType;
}

- (void)handleLaunchWithActivity:(NSUserActivity *)activity {
    NSString *itemIdentifier = [self itemIdentifierFromActivity:activity];
    id object = nil;
    if (itemIdentifier) {
        object = [self.objectTransformer objectForIdentifier:itemIdentifier];
    }
    [self.launchRouter openScreenWithData:object];
}

#pragma mark - Private methods

- (NSString *)itemIdentifierFromActivity:(NSUserActivity *)activity {
    NSString *activityIdentifier = activity.userInfo[kQuickActionItemIdentifierKey];
    return activityIdentifier;
}

@end
