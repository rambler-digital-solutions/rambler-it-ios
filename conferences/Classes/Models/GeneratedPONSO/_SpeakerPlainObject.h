//
//  _Speaker.h
//
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import <Foundation/Foundation.h>

@class LecturePlainObject;
@class SocialNetworkAccountPlainObject;

@interface _SpeakerPlainObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readwrite) NSString *biography;
@property (nonatomic, copy, readwrite) NSString *company;
@property (nonatomic, copy, readwrite) NSString *imageUrl;
@property (nonatomic, copy, readwrite) NSString *job;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *speakerId;

@property (nonatomic, copy, readwrite) NSSet<LecturePlainObject *> *lectures;

@property (nonatomic, copy, readwrite) NSSet<SocialNetworkAccountPlainObject *> *socialNetworkAccounts;

@end
