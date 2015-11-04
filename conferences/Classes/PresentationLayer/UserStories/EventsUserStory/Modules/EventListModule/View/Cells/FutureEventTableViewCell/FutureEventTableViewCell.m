//
//  FutureEventTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "FutureEventTableViewCell.h"
#import "FutureEventTableViewCellObject.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "EXTScope.h"

static NSString *const kPlaceholderImageName = @"placeholder";

@interface FutureEventTableViewCell ()

@property (assign, nonatomic) CGFloat FutureEventTableViewCellHeight;

@end

@implementation FutureEventTableViewCell

- (BOOL)shouldUpdateCellWithObject:(FutureEventTableViewCellObject *)object {
    self.eventTitle.text = object.eventTitle;
    self.day.text = object.day;
    self.month.text = object.month;
    self.imageView.image = object.image;
    [self.cellView setBackgroundColor:object.backgroundColor];
    self.imageView.image = [UIImage imageNamed:kPlaceholderImageName];
//    if (object.image) {
//        self.imageView.image = object.image;
//    } else {
//        @weakify(self);
//        [self obtainImageWithUrl:object.imageUrl completionBlock:^(UIImage *image) {
//            @strongify(self);
//            self.imageView.image = image;
//        }];
//    }
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return tableView.frame.size.height - 64;
}

#pragma mark - Private methods

- (void)obtainImageWithUrl:(NSURL *)url completionBlock:(void(^)(UIImage *image))completionBlock {
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:url
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                NSLog(@"receivedSize: %ld expectedSize: %ld", (long)receivedSize, (long)expectedSize);
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if (image && finished) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       completionBlock(image);
                                   });
                               }
                           }];
}

@end
