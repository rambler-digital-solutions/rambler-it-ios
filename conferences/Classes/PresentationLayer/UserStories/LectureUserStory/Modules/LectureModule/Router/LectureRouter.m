// Copyright (c) 2016 RAMBLER&Co
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

#import "LectureRouter.h"

#import "SpeakerInfoModuleInput.h"
#import "LectureViewController.h"
#import "SafariFactory.h"
#import "YouTubePlayerFactory.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

static NSString *const LectureModuleToSpeakerInfoModuleSegue = @"LectureModuleToSpeakerInfoModuleSegue";

@implementation LectureRouter

#pragma mark - LectureRouterInput

- (void)openSpeakerInfoModuleWithSpeakerObjectId:(NSString *)objectId {
    [[self.transitionHandler openModuleUsingSegue:LectureModuleToSpeakerInfoModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<SpeakerInfoModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithSpeakerId:objectId];
        
        return nil;
    }];
}

- (void)openWebBrowserModuleWithUrl:(NSURL *)url {
    UIViewController *safariViewController = [self.safariFactory createSafariViewControllerWithUrl:url];
    [(id)self.transitionHandler presentViewController:safariViewController
                                             animated:YES
                                           completion:nil];
}

- (void)openYouTubeVideoPlayerModuleWithIdentifier:(NSString *)identifier {
    UIViewController *playerController = [self.youTubePlayerFactory createYouTubePlayerControllerWithVideoIdentifier:identifier];
    [(id)self.transitionHandler presentViewController:playerController
                                             animated:YES
                                           completion:nil];
}

- (void)openShareModuleWithActivityItems:(NSArray *)activityItems {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [((LectureViewController *)self.transitionHandler).navigationController presentViewController:activityViewController animated:true completion:nil];
}

- (void)openLocalVideoPlayerModuleWithPath:(NSString *)path {
    NSURL *moveUrl = [NSURL fileURLWithPath:path];
    AVPlayer *player = [AVPlayer playerWithURL:moveUrl];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    [(id)self.transitionHandler presentViewController:playerViewController
                                             animated:YES
                                           completion:nil];
}

- (void)showAlertConfirmationRemoveWithActionBlock:(ActionAlertBlock)block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Удалить"
                                                                             message:@"Вы уверены?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Удалить"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              block();
                                                          }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [(id)self.transitionHandler presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (void)showAlertConfirmationDownloadWithActionBlock:(ActionAlertBlock)block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Скачать"
                                                                             message:@"Вы уверены?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Скачать"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              block();
                                                          }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [(id)self.transitionHandler presentViewController:alertController
                                             animated:YES
                                           completion:nil];
}

@end
