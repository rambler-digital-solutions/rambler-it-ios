//
//  SocialNetworkType.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

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
