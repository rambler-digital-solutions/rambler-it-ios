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

#import "SpeakerInfoPresenter.h"

#import "SpeakerInfoViewInput.h"
#import "SpeakerInfoInteractorInput.h"
#import "SpeakerInfoRouterInput.h"
#import "SpeakerInfoPresenterStateStorage.h"
#import "LecturePlainObject.h"

@implementation SpeakerInfoPresenter

#pragma mark - SpeakerInfoViewOutput

- (void)setupView {
    SpeakerPlainObject *speaker = [self.interactor obtainSpeakerWithSpeakerId:self.stateStorage.speakerId];
    [self.view setupViewWithSpeaker:speaker];
}

- (void)didTriggerSocialNetworkTapEventWithUrl:(NSURL *)socialUrl {
    [self.router openWebBrowserModuleWithUrl:socialUrl];
}

- (void)didTriggerLectureTapEventWithLecture:(LecturePlainObject *)lecture {
    NSString *lectureId = lecture.lectureId;
    [self.router openLectureModuleWithLectureId:lectureId];
}

- (void)didTriggerShareButtonTapEvent {
    SpeakerPlainObject *speaker = [self.interactor obtainSpeakerWithSpeakerId:self.stateStorage.speakerId];
    NSArray *activityItems = [self.interactor obtainActivityItemsForSpeaker:speaker];
    
    [self.router openShareModuleWithActivityItems:activityItems];
}

#pragma mark - SpeakerInfoInteractorOutput

#pragma mark - SpeakerInfoModuleInput

- (void)configureCurrentModuleWithSpeakerId:(NSString *)speakerId {
    self.stateStorage.speakerId = speakerId;
}

@end