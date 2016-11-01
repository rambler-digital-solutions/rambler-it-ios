//
//  MessagesUserActivityFactory.h
//  Conferences
//
//  Created by Trishina Ekaterina on 28/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Trishina Ekaterina

 This Factory is responsible for creating NSUserActivity from UIApplicationURL
 */
@interface MessagesUserActivityFactory : NSObject

/**
 @author Trishina Ekaterina

 Creates NSUserActivity

 @param URL

 @return NSUserActivity
 */
- (NSUserActivity *)createUserActivityFromURL:(NSURL *)url;

@end
