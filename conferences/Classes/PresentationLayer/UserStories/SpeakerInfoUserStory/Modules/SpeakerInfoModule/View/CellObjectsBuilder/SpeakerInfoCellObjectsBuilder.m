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

#import "SpeakerInfoCellObjectsBuilder.h"
#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoSocialContactsCellObject.h"
#import "SocialNetworkAccountPlainObject.h"
#import "SocialContactsConfigurator.h"
#import "SpeakerInfoSectionHeaderCellObject.h"
#import "SpeakerPlainObject.h"
#import "LocalizedStrings.h"

@implementation SpeakerInfoCellObjectsBuilder

- (NSArray *)buildObjectsWithSpeaker:(SpeakerPlainObject *)speaker {
    NSMutableArray *cellObjects = [NSMutableArray new];
    
    SpeakerInfoTableViewCellObject *speakerInfoCellObject = [SpeakerInfoTableViewCellObject objectWithSpeaker:speaker];
    
    [cellObjects addObject:speakerInfoCellObject];
    
    NSMutableArray *accounts = [[speaker.socialNetworkAccounts allObjects] mutableCopy];
    NSInteger websiteIndex = [accounts indexOfObjectPassingTest:^BOOL(SocialNetworkAccountPlainObject * _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        return object.type.integerValue == SocialNetworkWebsiteType;
    }];
    
    if (websiteIndex != NSNotFound) {
        SocialNetworkAccountPlainObject *website = accounts[websiteIndex];
        NSArray *websiteCellObjects = [self buildWebsiteCellObjectsWithAccount:website];
        [cellObjects addObjectsFromArray:websiteCellObjects];
        [accounts removeObject:website];
    }
    
    if (accounts.count) {
        NSArray *socialAccounts = [self buildSocialContactsCellObjectsWithAccounts:accounts];
        [cellObjects addObjectsFromArray:socialAccounts];
    }
    
    return cellObjects;

}

- (NSArray *)buildWebsiteCellObjectsWithAccount:(SocialNetworkAccountPlainObject *)account {
    NSMutableArray *cellObjects = [NSMutableArray new];
    SpeakerInfoSectionHeaderCellObject *headerCellObject = [SpeakerInfoSectionHeaderCellObject objectWithText:RCLocalize(kSpeakerInfoWebsiteSectionName)];
    [cellObjects addObject:headerCellObject];
    
    NSString *image = [self.configurator configureImageForSocialAccount:account];
    NSString *text = [self.configurator configureNameForSocialAccount:account];
    SpeakerInfoSocialContactsCellObject *cellObject = [SpeakerInfoSocialContactsCellObject objectWithSocialNetworkAccount:account
                                                                                                                    image:image
                                                                                                                     text:text];
    [cellObjects addObject:cellObject];

    return [cellObjects copy];
}

- (NSArray *)buildSocialContactsCellObjectsWithAccounts:(NSArray *)socialAccounts {
    
    NSMutableArray *cellObjects = [NSMutableArray new];
    SpeakerInfoSectionHeaderCellObject *cellObject = [SpeakerInfoSectionHeaderCellObject objectWithText:RCLocalize(kSpeakerInfoSocialNetworksSectionName)];
    [cellObjects addObject:cellObject];
    
    for (SocialNetworkAccountPlainObject *account in socialAccounts) {
        NSString *image = [self.configurator configureImageForSocialAccount:account];
        NSString *text = [self.configurator configureNameForSocialAccount:account];
        SpeakerInfoSocialContactsCellObject *cellObject = [SpeakerInfoSocialContactsCellObject objectWithSocialNetworkAccount:account
                                                                                                                        image:image
                                                                                                                         text:text];
        [cellObjects addObject:cellObject];
    }
    
    return [cellObjects copy];
}

@end
