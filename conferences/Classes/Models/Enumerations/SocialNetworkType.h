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

#ifndef SocialNetworkType_h
#define SocialNetworkType_h

/**
 @author Egor Tolstoy
 
 Enumeration with different social networks types
 */
typedef NS_ENUM(NSUInteger, SocialNetworkType) {
    /**
     @author Egor Tolstoy
     
     Unknown social network
     */
    SocialNetworkUndefinedType = 0,
    /**
     @author Egor Tolstoy
     
     Facebook
     */
    SocialNetworkFacebookType = 1,
    /**
     @author Egor Tolstoy
     
     Twitter
     */
    SocialNetworkTwitterType = 2,
    /**
     @author Egor Tolstoy
     
     GitHub
     */
    SocialNetworkGitHubType = 3,
    /**
     @author Egor Tolstoy
     
     LinkedIn
     */
    SocialNetworkLinkedInType = 4,
    /**
     @author Egor Tolstoy
     
     VKontakte
     */
    SocialNetworkVkontakteType = 5,
    
    /**
     @author Egor Tolstoy
     
     Email
     */
    SocialNetworkEmailType = 6,
    
    /**
     @author Egor Tolstoy
     
     Instagram
     */
    SocialNetworkInstagramType = 7,
    
    /**
     @author Egor Tolstoy
     
     Website
     */
    SocialNetworkWebsiteType = 8
};

#endif /* SocialNetworkType_h */
