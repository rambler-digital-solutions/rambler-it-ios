//
//  _Tech.h
//
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import <Foundation/Foundation.h>

@class EventPlainObject;

@interface _TechPlainObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readwrite) NSString *color;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *techId;

@property (nonatomic, copy, readwrite) NSSet<EventPlainObject *> *events;

@end
