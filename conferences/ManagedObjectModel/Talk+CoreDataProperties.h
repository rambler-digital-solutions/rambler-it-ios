//
//  Talk+CoreDataProperties.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Talk.h"

NS_ASSUME_NONNULL_BEGIN

@interface Talk (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *talkDescription;
@property (nullable, nonatomic, retain) NSString *slideLink;
@property (nullable, nonatomic, retain) NSString *videoLink;
@property (nullable, nonatomic, retain) NSNumber *orderID;
@property (nullable, nonatomic, retain) NSNumber *favourite;
@property (nullable, nonatomic, retain) Event *event;
@property (nullable, nonatomic, retain) NSSet<TalkMaterial *> *talk;
@property (nullable, nonatomic, retain) NSSet<Speaker *> *speakers;

@end

@interface Talk (CoreDataGeneratedAccessors)

- (void)addTalkObject:(TalkMaterial *)value;
- (void)removeTalkObject:(TalkMaterial *)value;
- (void)addTalk:(NSSet<TalkMaterial *> *)values;
- (void)removeTalk:(NSSet<TalkMaterial *> *)values;

- (void)addSpeakersObject:(Speaker *)value;
- (void)removeSpeakersObject:(Speaker *)value;
- (void)addSpeakers:(NSSet<Speaker *> *)values;
- (void)removeSpeakers:(NSSet<Speaker *> *)values;

@end

NS_ASSUME_NONNULL_END
