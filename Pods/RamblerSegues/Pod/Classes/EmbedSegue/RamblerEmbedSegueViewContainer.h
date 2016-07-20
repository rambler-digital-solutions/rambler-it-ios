//
//  RamblerEmbedSegueViewContainer.h
//  Pods
//
//  Created by Andrey Zarembo-Godzyatsky on 25/09/15.
//
//

#import <Foundation/Foundation.h>

/**
 Protocol for viewController, which is used to determine what view should be used for embed segue
 */
@protocol RamblerEmbedSegueViewContainer <NSObject>

/**
 This method returns a container view for a specified identifier
 
 @param embedIdentifier Embed Segue Identifier
 
 @return Container view
 */
- (UIView *)viewForEmbedIdentifier:(NSString *)embedIdentifier;

@end
