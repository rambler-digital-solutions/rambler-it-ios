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

@class SocialNetworkAccountPlainObject;

/**
 @author Vasyura Anastasiya
 
 The class is used to configure cellObject fields with account
 */
@interface SocialContactsConfigurator : NSObject

/**
 @author Vasyura Anastasiya
 
 Method configure social account title by account type
 
 @param account account
 
 @return title
 */
- (NSString *)configureNameForSocialAccount:(SocialNetworkAccountPlainObject *)account;

/**
 @author Vasyura Anastasiya
 
 Method configure social account image by account type
 
 @param account account
 
 @return image
 */
- (NSString *)configureImageForSocialAccount:(SocialNetworkAccountPlainObject *)account;

@end
