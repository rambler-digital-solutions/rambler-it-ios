//
//  _MetaEvent.h
//
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import <Foundation/Foundation.h>

@class EventPlainObject;

@interface _MetaEventPlainObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readwrite) NSString *imageUrlPath;
@property (nonatomic, copy, readwrite) NSString *metaEventDescription;
@property (nonatomic, copy, readwrite) NSString *metaEventId;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *websiteUrlPath;

@property (nonatomic, copy, readwrite) NSSet<EventPlainObject *> *events;

@end
