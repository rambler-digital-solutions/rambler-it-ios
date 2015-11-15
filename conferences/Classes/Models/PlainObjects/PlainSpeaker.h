//
//  PlainSpeaker.h
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlainSpeaker : NSObject

// пока окончательно не сформирована модель данных - все проперти readwrite
// добавить companyName в модель

@property (strong, nonatomic, readwrite) NSString *biography;
@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSURL *pictureLink;
@property (strong, nonatomic, readwrite) NSArray *socialNetworkAccounts;
@property (strong, nonatomic, readwrite) NSString *companyName;

@end
