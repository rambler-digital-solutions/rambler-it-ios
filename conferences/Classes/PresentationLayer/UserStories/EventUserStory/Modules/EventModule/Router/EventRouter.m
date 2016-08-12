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

#import "EventRouter.h"

#import "LectureModuleInput.h"
#import "SpeakerInfoModuleInput.h"
#import "EventViewController.h"
#import "EventModuleInput.h"
#import "EventModuleSegueIdentifiersConstants.h"

@implementation EventRouter

#pragma mark - EventRouterInput

- (void)openLectureModuleWithLectureObjectId:(NSString *)lectureObjectId {
    [[self.transitionHandler openModuleUsingSegue:kEventModuleToLectureModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<LectureModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithLectureObjectId:lectureObjectId];
        return nil;
    }];
}

- (void)openEventModuleWithEventId:(NSString *)eventId {
    [[self.transitionHandler openModuleUsingSegue:kEventModuleToEventModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<EventModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithEventObjectId:eventId];
        return nil;
    }];
}

- (void)openShareModuleWithActivityItems:(NSArray *)activityItems {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

    [((EventViewController *)self.transitionHandler).navigationController presentViewController:activityViewController animated:true completion:nil];
}

- (void)openSpeakerInfoModuleWithSpeakerId:(NSString *)speakerId {
    [[self.transitionHandler openModuleUsingSegue:kEventModuleToSpeakerModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<SpeakerInfoModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithSpeakerId:speakerId];
        return nil;
    }];
}

@end