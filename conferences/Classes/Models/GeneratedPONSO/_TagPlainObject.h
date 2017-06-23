//
//  _Tag.h
//
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

#import <Foundation/Foundation.h>

@class LecturePlainObject;

@interface _TagPlainObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *slug;
@property (nonatomic, copy, readwrite) NSString *tagId;

@property (nonatomic, copy, readwrite) NSSet<LecturePlainObject *> *lectures;

@end
